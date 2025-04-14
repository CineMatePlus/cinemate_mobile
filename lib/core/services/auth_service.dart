import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'api_service.dart';
import '../providers/api_service_provider.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(Ref ref) : _apiService = ref.read(apiServiceProvider);

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  Future<User> register(String username, String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/register',
        data: {'username': username, 'email': email, 'password': password},
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Kayıt başarısız: $e');
    }
  }

  Future<void> logout() async {
    /* try {
      await _apiService.post('/auth/logout');
    } catch (e) {
      throw Exception('Çıkış başarısız: $e');
    } */
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _apiService.get('/auth/me');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Kullanıcı bilgileri alınamadı: $e');
    }
  }
}
