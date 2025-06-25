import 'dart:developer';

import 'package:cinemate_mobile/core/modules/auth/utils/auth.utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/api_service_provider.dart';
import '../models/user.dart';
import '../../../services/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.request(
        'POST',
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      log("Giriş cevabı: ${response.statusCode}", name: 'AuthService');
      log("Giriş cevabı: ${response.data.toString()}", name: 'AuthService');
      if (response.statusCode == 200) {
        // Token'ı local storage'a kaydet
        //TODO: Bunu state'e çekeriz
        await AuthUtils.saveToken(response.data['access_token']);

        return User.fromJson(response.data['user']);
      } else {
        throw Exception('Giriş başarısız');
      }
    } catch (e) {
      log('Giriş hatası: $e', name: 'AuthService', error: e);
      throw Exception('Giriş sırasında bir hata oluştu: $e');
    }
  }

  Future<User> register(
      String email, String password, String name, int gender) async {
    try {
      final response = await _apiService.request(
        'POST',
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'gender': gender,
        },
      );

      if (response.statusCode == 200) {
        // Token'ı local storage'a kaydet
        //TODO: Bunu state'e çekeriz
        await AuthUtils.saveToken(response.data['access_token']);

        return User.fromJson(response.data['user']);
      } else {
        throw Exception('Kayıt başarısız');
      }
    } catch (e) {
      log('Kayıt hatası: $e', name: 'AuthService', error: e);
      throw Exception('Kayıt sırasında bir hata oluştu: $e');
    }
  }

  Future<User?> refreshTokenAndGetUser() async {
    try {
      final token = await AuthUtils.getToken();

      if (token == null || token.isEmpty) {
        return null;
      }

      // Token'ın geçerliliğini API ile kontrol et ve yeni token + user bilgilerini al
      final response = await _apiService.request('POST', '/auth/refresh');
      log("Status Code = ${response.statusCode}", name: 'AuthService');
      log("Token yenileme cevabı: ${response.data.toString()}",
          name: 'AuthService');
      if (response.statusCode == 200) {
        // Yeni token'ı kaydet
        final newToken = response.data['access_token'];
        await AuthUtils.saveToken(newToken);

        // Kullanıcı bilgilerini döndür
        return User.fromJson(response.data['user']);
      } else {
        // Token geçersiz, storage'dan temizle
        await AuthUtils.deleteToken();
        return null;
      }
    } catch (e) {
      log(
        'Token yenileme ve kullanıcı bilgileri alma hatası: $e',
        name: 'AuthService',
        error: e,
      );
      // Hata durumunda token'ı temizle
      await AuthUtils.deleteToken();
      return null;
    }
  }

  Future<void> logout() async {
    try {
      // Token'ı temizle
      await AuthUtils.deleteToken();
    } catch (e) {
      log('Çıkış hatası: $e', name: 'AuthService', error: e);
      throw AuthException('Çıkış işlemi sırasında bir hata oluştu: $e');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

// Auth Service Provider
final authServiceProvider = Provider<AuthService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthService(apiService: apiService);
});
