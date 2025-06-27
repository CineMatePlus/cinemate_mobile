import 'package:cinemate_mobile/core/providers/api_service_provider.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// İstatistik verilerini tutacak olan model
class UserStats {
  final int likedCount;
  final int watchlistCount;
  final int watchedCount;

  UserStats({
    required this.likedCount,
    required this.watchlistCount,
    required this.watchedCount,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      likedCount: json['likes'] ?? 0,
      watchlistCount: json['watchlist'] ?? 0,
      watchedCount: json['watched'] ?? 0,
    );
  }
}

enum UserListType {
  liked,
  watchlist,
  watched,
}

class UserService {
  final ApiService _apiService;

  UserService(this._apiService);

  Future<List<Movie>> _getUserMovies(String endpoint,
      {int skip = 0, int limit = 20}) async {
    try {
      final response = await _apiService.request(
        'GET',
        '$endpoint?skip=$skip&limit=$limit',
      );

      if (response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Unexpected response format for user movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> getLikedMovies({int skip = 0, int limit = 20}) {
    return _getUserMovies('/users/me/liked-movies', skip: skip, limit: limit);
  }

  Future<List<Movie>> getWatchlist({int skip = 0, int limit = 20}) {
    return _getUserMovies('/users/me/watchlist', skip: skip, limit: limit);
  }

  Future<List<Movie>> getWatchedHistory({int skip = 0, int limit = 20}) {
    return _getUserMovies('/users/me/watched-history',
        skip: skip, limit: limit);
  }

  Future<UserStats> getUserStats() async {
    try {
      final response = await _apiService.request('GET', '/users/me/stats');
      return UserStats.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> getRecommendations(
      {required String basedOn, int skip = 0, int limit = 10}) async {
    try {
      final response = await _apiService.request(
        'GET',
        '/users/me/recommendations?based_on=$basedOn&skip=$skip&limit=$limit',
      );
      if (response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Unexpected response format for recommendations');
      }
    } catch (e) {
      rethrow;
    }
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserService(apiService);
});
