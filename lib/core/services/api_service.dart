import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'session_store.dart';

class ApiConfig {
  static String get baseUrl {
    const configured = String.fromEnvironment('API_BASE_URL');
    const localDemo = bool.fromEnvironment('ALLOW_LOCAL_DEMO');
    final url = configured.isNotEmpty
        ? configured
        : defaultTargetPlatform == TargetPlatform.android
        ? 'http://10.0.2.2:8000'
        : 'http://127.0.0.1:8000';
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasAuthority ||
        !['http', 'https'].contains(uri.scheme) ||
        (kReleaseMode &&
            (configured.isEmpty || (uri.scheme != 'https' && !localDemo)))) {
      throw StateError(
        'Release için HTTPS API_BASE_URL belirtin. Yerel demo için ALLOW_LOCAL_DEMO=true kullanın.',
      );
    }
    return url.replaceAll(RegExp(r'/$'), '');
  }

  static const apiPrefix = '/api/v1';
}

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;
  @override
  String toString() => message;
}

class ApiService {
  ApiService({Dio? dio, SessionStore? store})
    : _dio = dio ?? Dio(),
      store = store ?? const SecureSessionStore() {
    _dio.options = BaseOptions(
      baseUrl: _dio.options.baseUrl.isEmpty
          ? ApiConfig.baseUrl
          : _dio.options.baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 130),
      validateStatus: (status) => status != null && status < 500,
    );
  }
  final Dio _dio;
  final SessionStore store;
  Future<SessionTokens?>? _refreshing;
  int _generation = 0;
  VoidCallback? onSessionExpired;

  Future<void> saveSession(Map<String, dynamic> data) async {
    _generation++;
    await store.write(SessionTokens.fromJson(data));
  }

  Future<void> clearSession() async {
    _generation++;
    await store.clear();
    onSessionExpired?.call();
  }

  Future<SessionTokens?> refreshSession() async {
    final pending = _refreshing;
    if (pending != null) return pending;
    final future = _rotateSession();
    _refreshing = future;
    try {
      return await future;
    } finally {
      if (identical(_refreshing, future)) _refreshing = null;
    }
  }

  Future<SessionTokens?> _rotateSession() async {
    final generation = _generation;
    final current = await store.read();
    if (current == null) return null;
    final response = await _send(
      'POST',
      '/auth/refresh',
      data: {'refresh_token': current.refreshToken},
    );
    if (generation != _generation) return null;
    if (response.statusCode == 401 || response.statusCode == 422) {
      await clearSession();
      return null;
    }
    _check(response);
    final tokens = SessionTokens.fromJson(
      response.data as Map<String, dynamic>,
    );
    await store.write(tokens);
    return tokens;
  }

  Future<Response> request(
    String method,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    final isAuth =
        path.startsWith('/auth/') &&
        path != '/auth/me' &&
        path != '/auth/change-password' &&
        path != '/auth/logout-all';
    final session = isAuth ? null : await store.read();
    var response = await _send(
      method,
      path,
      data: data,
      headers: headers,
      accessToken: session?.accessToken,
    );
    if (response.statusCode == 401 && !isAuth && session != null) {
      // A late 401 may belong to the token that another request already rotated.
      var latest = await store.read();
      if (latest?.accessToken == session.accessToken) {
        latest = await refreshSession();
      }
      if (latest != null) {
        // Only an explicit authentication rejection is retried, never a timeout.
        response = await _send(
          method,
          path,
          data: data,
          headers: headers,
          accessToken: latest.accessToken,
        );
      }
      if (response.statusCode == 401) await clearSession();
    }
    _check(response);
    return response;
  }

  Future<Response> _send(
    String method,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    String? accessToken,
  }) async {
    try {
      return await _dio.request(
        path.startsWith('/health/') ? path : '${ApiConfig.apiPrefix}$path',
        data: data,
        options: Options(
          method: method,
          headers: {
            ...?headers,
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        throw ApiException(
          'Sunucu geçici olarak kullanılamıyor. Tekrar deneyin.',
          statusCode: error.response?.statusCode,
        );
      }
      throw const ApiException(
        'Bağlantı kurulamadı veya zaman aşımına uğradı. Tekrar deneyin.',
      );
    }
  }

  void _check(Response response) {
    final code = response.statusCode ?? 0;
    if (code >= 200 && code < 300) return;
    final detail = response.data is Map ? response.data['detail'] : null;
    throw ApiException(
      detail is String
          ? detail
          : code == 422
          ? 'Bilgileri kontrol edin. Geçerli e-posta ve 8–32 karakter parola kullanın.'
          : code == 401
          ? 'Oturum sona erdi. Lütfen tekrar giriş yapın.'
          : 'İşlem tamamlanamadı. Lütfen tekrar deneyin.',
      statusCode: code,
    );
  }

  void close() => _dio.close();
}
