import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/models/user.dart';
import '../../../core/services/api_service.dart';

class AuthService {
  final ApiService _apiService;
  final FlutterSecureStorage _secureStorage;
  static const String _tokenKey = 'auth_token';

  AuthService(this._apiService) : _secureStorage = const FlutterSecureStorage();

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final token = response.data['token'];
      await _secureStorage.write(key: _tokenKey, value: token);

      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  Future<User> register(String name, String email, String password) async {
    try {
      final response = await _apiService.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      final token = response.data['token'];
      await _secureStorage.write(key: _tokenKey, value: token);

      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Kayıt başarısız: $e');
    }
  }

  Future<void> logout() async {
    /*  try {
      await _apiService.post('/auth/logout');
      await _secureStorage.delete(key: _tokenKey);
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

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }
}
