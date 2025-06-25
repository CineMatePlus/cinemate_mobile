import 'package:cinemate_mobile/core/providers/api_service_provider.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie_model.dart';

enum InteractionType {
  like,
  watched,
  watchlist,
}

class MovieService {
  final ApiService _apiService;

  MovieService(this._apiService);

  Future<List<Movie>> getMovies({int skip = 0, int limit = 10}) async {
    try {
      final response = await _apiService.request(
        'GET',
        '/movies?skip=$skip&limit=$limit',
      );

      if (response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      // Hata yönetimi burada daha detaylı yapılabilir.
      rethrow;
    }
  }

  Future<Movie> getMovieById(String movieId) async {
    try {
      final response = await _apiService.request(
        'GET',
        '/movies/$movieId',
      );
      return Movie.fromJson(response.data);
    } catch (e) {
      // Hata yönetimi burada daha detaylı yapılabilir.
      rethrow;
    }
  }

  Future<void> toggleInteraction(
      String movieId, InteractionType interactionType) async {
    try {
      // İstek başarılı olursa bir şey döndürmesine gerek yok.
      // Başarısız olursa ApiService katmanı hata fırlatacaktır.
      await _apiService.request(
        'POST',
        '/interactions/$movieId/${interactionType.name}',
      );
    } catch (e) {
      rethrow;
    }
  }

  // İlgili filmleri getiren metod
  Future<List<Movie>> getRelatedMovies(String movieId,
      {int skip = 0, int limit = 10}) async {
    try {
      final response = await _apiService.request(
        'GET',
        '/movies/$movieId/similar?skip=$skip&limit=$limit',
      );

      if (response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Unexpected response format for related movies');
      }
    } catch (e) {
      rethrow;
    }
  }
}

final movieServiceProvider = Provider<MovieService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return MovieService(apiService);
});
