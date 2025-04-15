import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000'; // Android emulator için
    } else if (Platform.isIOS) {
      return 'http://localhost:8000'; // iOS simulator için
    } else {
      return 'http://127.0.0.1:8000'; // Diğer platformlar için
    }
  }

  static const String apiPrefix = '/api/v1';
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 3);
}

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: ApiConfig.connectTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
          ),
        ),
        _storage = const FlutterSecureStorage() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.path = _buildPath(options.path);
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _storage.delete(key: 'access_token');
            // TODO: Navigate to login screen
          }
          return handler.next(error);
        },
      ),
    );
  }

  String _buildPath(String path) {
    return path == '/health' ? path : '${ApiConfig.apiPrefix}$path';
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('İstek sırasında beklenmeyen bir hata oluştu: $e');
    }
  }

  Future<Response> post(String path,
      {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('İstek sırasında beklenmeyen bir hata oluştu: $e');
    }
  }

  Future<Response> put(String path,
      {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('İstek sırasında beklenmeyen bir hata oluştu: $e');
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
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
