import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    } else if (Platform.isIOS) {
      return 'http://localhost:8000';
    } else {
      return 'http://127.0.0.1:8000';
    }
  }

  static const String apiPrefix = '/api/v1';
}

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            validateStatus: (status) => status! < 500,
          ),
        ),
        _storage = const FlutterSecureStorage() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.path = _buildPath(options.path);
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _storage.delete(key: 'token');
          }
          return handler.next(error);
        },
      ),
    );
  }

  String _buildPath(String path) {
    return path == '/health' ? path : '${ApiConfig.apiPrefix}$path';
  }

  Future<Response> request(
    String method,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      if (data != null) {
        log('Giden veri: ${data.toString()}');
      }

      switch (method.toUpperCase()) {
        case 'GET':
          return await _dio.get(path);
        case 'POST':
          return await _dio.post(path, data: data);
        case 'PUT':
          return await _dio.put(path, data: data);
        case 'DELETE':
          return await _dio.delete(path);
        default:
          return await _dio.get(path);
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('İstek sırasında beklenmeyen bir hata oluştu: $e');
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
            'Sunucuya bağlanırken zaman aşımı oluştu. Lütfen internet bağlantınızı kontrol edin.');
      case DioExceptionType.connectionError:
        return Exception(
            'Sunucuya bağlanılamıyor. Lütfen sunucunun çalıştığından ve doğru adreste olduğundan emin olun.');
      case DioExceptionType.badResponse:
        return Exception('Sunucu hatası: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('İstek iptal edildi');
      default:
        return Exception('Bir hata oluştu: ${e.message}');
    }
  }
}
