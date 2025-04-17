import '../../../core/models/user.dart';
import '../../../core/services/api_service.dart';

class UserService {
  final ApiService _apiService;

  UserService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.request(
        'POST',
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return {
          'user': User.fromJson(response.data['user']),
          'access_token': response.data['access_token'],
        };
      } else {
        throw Exception('Giriş başarısız');
      }
    } catch (e) {
      throw Exception('Giriş sırasında bir hata oluştu: $e');
    }
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    try {
      final response = await _apiService.request(
        'POST',
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        return {
          'user': User.fromJson(response.data['user']),
          'access_token': response.data['access_token'],
        };
      } else {
        throw Exception('Kayıt başarısız');
      }
    } catch (e) {
      throw Exception('Kayıt sırasında bir hata oluştu: $e');
    }
  }

  Future<User> me() async {
    try {
      final response = await _apiService.request(
        'GET',
        '/auth/me',
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Profil yüklenirken bir hata oluştu');
      }
    } catch (e) {
      throw Exception('Profil yüklenirken bir hata oluştu: $e');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _apiService.request(
        'POST',
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
      final response = await _apiService.request(
        'POST',
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
      final response = await _apiService.request(
        'POST',
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
