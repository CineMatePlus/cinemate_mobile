import '../../../core/models/user.dart';
import '../../../core/services/api_service.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

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
}
