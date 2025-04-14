import '../../../core/services/api_service.dart';
import '../models/movie.dart';
import '../models/movie_detail.dart';

class MovieService {
  final ApiService _apiService;

  MovieService(this._apiService);

  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await _apiService.get('/movies/popular');
      return (response.data as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Popüler filmler alınamadı: $e');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response = await _apiService.get('/movies/upcoming');
      return (response.data as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Yakında gelecek filmler alınamadı: $e');
    }
  }

  Future<List<Movie>> getRecommendedMovies() async {
    try {
      final response = await _apiService.get('/movies/recommended');
      return (response.data as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Önerilen filmler alınamadı: $e');
    }
  }

  Future<MovieDetail> getMovieDetail(String movieId) async {
    try {
      final response = await _apiService.get('/movies/$movieId');
      return MovieDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Film detayları alınamadı: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _apiService.get('/movies/search?query=$query');
      return (response.data as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Film araması başarısız: $e');
    }
  }
}
