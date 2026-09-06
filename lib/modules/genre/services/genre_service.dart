import 'package:cinemate_mobile/core/providers/api_service_provider.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreService {
  final ApiService _apiService;

  GenreService(this._apiService);

  Future<List<Movie>> getMoviesByGenre(String genreName) async {
    try {
      final response = await _apiService.request(
        'GET',
        '/movies/genre/$genreName',
      );
      if (response.data is List) {
        final List<dynamic> data = response.data;
        return data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Unexpected response format for movies by genre');
      }
    } catch (e) {
      rethrow;
    }
  }
}

final genreServiceProvider = Provider<GenreService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return GenreService(apiService);
});
