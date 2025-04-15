import '../../../core/models/user.dart';
import '../../../core/services/api_service.dart';

class UserService {
  final ApiService _apiService;

  UserService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Giriş başarısız');
      }
    } catch (e) {
      throw Exception('Giriş sırasında bir hata oluştu: $e');
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      final response = await _apiService.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Kayıt başarısız');
      }
    } catch (e) {
      throw Exception('Kayıt sırasında bir hata oluştu: $e');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _apiService.post(
        '/auth/forgot-password',
        data: {
          'email': email,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Şifre sıfırlama başarısız');
      }
    } catch (e) {
      throw Exception('Şifre sıfırlama sırasında bir hata oluştu: $e');
    }
  }

  Future<bool> verifyResetCode(String email, String code) async {
    try {
      final response = await _apiService.post(
        '/auth/verify-reset-code',
        data: {
          'email': email,
          'code': code,
        },
      );

      if (response.statusCode == 200) {
        return response.data['isValid'] as bool;
      } else {
        throw Exception('Kod doğrulama başarısız');
      }
    } catch (e) {
      throw Exception('Kod doğrulama sırasında bir hata oluştu: $e');
    }
  }

  Future<void> resetPassword(
      String email, String code, String newPassword) async {
    try {
      final response = await _apiService.post(
        '/auth/reset-password',
        data: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Şifre güncelleme başarısız');
      }
    } catch (e) {
      throw Exception('Şifre güncelleme sırasında bir hata oluştu: $e');
    }
  }
}
