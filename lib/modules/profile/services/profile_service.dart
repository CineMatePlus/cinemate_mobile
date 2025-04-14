import '../../../core/services/api_service.dart';
import '../models/user.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService(this._apiService);

  Future<User> getUserProfile() async {
    try {
      final response = await _apiService.get('/users/profile');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Profil bilgileri alınamadı: $e');
    }
  }

  Future<void> updateProfile({
    required String username,
    required String email,
    required String avatarUrl,
  }) async {
    try {
      await _apiService.put(
        '/users/profile',
        data: {
          'username': username,
          'email': email,
          'avatarUrl': avatarUrl,
        },
      );
    } catch (e) {
      throw Exception('Profil güncellenemedi: $e');
    }
  }

  Future<void> addToFavorites(String movieId) async {
    try {
      await _apiService.post(
        '/users/favorites',
        data: {'movieId': movieId},
      );
    } catch (e) {
      throw Exception('Favorilere eklenemedi: $e');
    }
  }

  Future<void> removeFromFavorites(String movieId) async {
    try {
      await _apiService.delete('/users/favorites/$movieId');
    } catch (e) {
      throw Exception('Favorilerden çıkarılamadı: $e');
    }
  }

  Future<void> addToWatchlist(String movieId) async {
    try {
      await _apiService.post(
        '/users/watchlist',
        data: {'movieId': movieId},
      );
    } catch (e) {
      throw Exception('İzleme listesine eklenemedi: $e');
    }
  }

  Future<void> removeFromWatchlist(String movieId) async {
    try {
      await _apiService.delete('/users/watchlist/$movieId');
    } catch (e) {
      throw Exception('İzleme listesinden çıkarılamadı: $e');
    }
  }

  Future<void> markAsWatched(String movieId) async {
    try {
      await _apiService.post(
        '/users/watched',
        data: {'movieId': movieId},
      );
    } catch (e) {
      throw Exception('İzlendi olarak işaretlenemedi: $e');
    }
  }
}
