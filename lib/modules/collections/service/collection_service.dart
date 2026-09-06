import 'package:cinemate_mobile/core/modules/auth/state.dart';
import 'package:cinemate_mobile/core/providers/api_service_provider.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/modules/collections/models/collection_model.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectionServiceProvider = Provider<CollectionService>((ref) {
  ref.watch(authProvider.select((state) => state.user?.id));
  final apiService = ref.watch(apiServiceProvider);
  return CollectionService(apiService);
});

class CollectionService {
  final ApiService _apiService;

  CollectionService(this._apiService);

  Future<List<Collection>> getMyCollections() async {
    final result = <Collection>[];
    for (var skip = 0; ; skip += 100) {
      final response = await _apiService.request(
        'GET',
        '/collections/me?skip=$skip&limit=100',
      );
      final page = (response.data as List)
          .map((json) => Collection.fromJson(json))
          .toList();
      result.addAll(page);
      if (page.length < 100) return result;
    }
  }

  Future<Collection> getCollectionDetails(String collectionId) async {
    final response = await _apiService.request(
      'GET',
      '/collections/$collectionId',
    );
    return Collection.fromJson(response.data);
  }

  Future<Collection> createCollection({
    required String name,
    required String description,
    required bool isPublic,
  }) async {
    final response = await _apiService.request(
      'POST',
      '/collections',
      data: {'name': name, 'description': description, 'is_public': isPublic},
    );
    return Collection.fromJson(response.data);
  }

  Future<Collection> updateCollection(
    String collectionId,
    String name,
    String description,
  ) async {
    final response = await _apiService.request(
      'PUT',
      '/collections/$collectionId',
      data: {'name': name, 'description': description},
    );
    return Collection.fromJson(response.data);
  }

  Future<void> deleteCollection(String collectionId) async {
    await _apiService.request('DELETE', '/collections/$collectionId');
  }

  Future<List<Movie>> getMoviesInCollection(String collectionId) async {
    final result = <Movie>[];
    for (var skip = 0; ; skip += 100) {
      final response = await _apiService.request(
        'GET',
        '/collections/$collectionId/movies?skip=$skip&limit=100',
      );
      final page = (response.data as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      result.addAll(page);
      if (page.length < 100) return result;
    }
  }

  Future<void> addMovieToCollection(String collectionId, String movieId) async {
    await _apiService.request(
      'POST',
      '/collections/$collectionId/movies/$movieId',
    );
  }

  Future<void> removeMovieFromCollection(
    String collectionId,
    String movieId,
  ) async {
    await _apiService.request(
      'DELETE',
      '/collections/$collectionId/movies/$movieId',
    );
  }

  Future<List<Movie>> getCollectionRecommendations(String collectionId) async {
    final response = await _apiService.request(
      'GET',
      '/collections/$collectionId/recommendations',
    );
    return (response.data as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }
}
