import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const String apiPrefix = '/api/v1';
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 3);
}

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  static const String _authTokenKey = 'auth_token';

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: ApiConfig.connectTimeout,
          receiveTimeout: ApiConfig.receiveTimeout,
        )),
        _secureStorage = const FlutterSecureStorage() {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<String?> _getAuthToken() async {
    return await _secureStorage.read(key: _authTokenKey);
  }

  Future<Options> _getOptions() async {
    final token = await _getAuthToken();
    return Options(
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  String _buildPath(String path) {
    return path == '/health' ? path : '${ApiConfig.apiPrefix}$path';
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(
        _buildPath(path),
        options: await _getOptions(),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {required dynamic data}) async {
    try {
      final response = await _dio.post(
        _buildPath(path),
        data: data,
        options: await _getOptions(),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {required dynamic data}) async {
    try {
      final response = await _dio.put(
        _buildPath(path),
        data: data,
        options: await _getOptions(),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(
        _buildPath(path),
        options: await _getOptions(),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
            'Sunucuya bağlanırken zaman aşımı oluştu. Lütfen internet bağlantınızı kontrol edin.');
      case DioExceptionType.badResponse:
        return Exception('Sunucu hatası: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('İstek iptal edildi');
      default:
        return Exception('Bir hata oluştu: ${e.message}');
    }
  }
}
