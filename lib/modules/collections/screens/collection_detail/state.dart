import 'package:cinemate_mobile/modules/collections/models/collection_model.dart';
import 'package:cinemate_mobile/modules/collections/service/collection_service.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class CollectionDetailState with _$CollectionDetailState {
  const factory CollectionDetailState({
    Collection? collection,
    @Default([]) List<Movie> movies,
    @Default([]) List<Movie> recommendations,
  }) = _CollectionDetailState;
}

final collectionDetailProvider = StateNotifierProvider.autoDispose.family<
    CollectionDetailNotifier,
    AsyncValue<CollectionDetailState>,
    String>((ref, collectionId) {
  final collectionService = ref.watch(collectionServiceProvider);
  return CollectionDetailNotifier(collectionService, collectionId);
});

class CollectionDetailNotifier
    extends StateNotifier<AsyncValue<CollectionDetailState>> {
  final CollectionService _collectionService;
  final String _collectionId;

  CollectionDetailNotifier(this._collectionService, this._collectionId)
      : super(const AsyncValue.loading()) {
    fetchCollectionDetails();
  }

  Future<void> fetchCollectionDetails() async {
    state = const AsyncValue.loading();
    try {
      final results = await Future.wait([
        _collectionService.getCollectionDetails(_collectionId),
        _collectionService.getMoviesInCollection(_collectionId),
        _collectionService.getCollectionRecommendations(_collectionId),
      ]);

      final collection = results[0] as Collection;
      final movies = results[1] as List<Movie>;
      final recommendations = results[2] as List<Movie>;

      state = AsyncValue.data(CollectionDetailState(
        collection: collection,
        movies: movies,
        recommendations: recommendations,
      ));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<bool> deleteCollection() async {
    try {
      await _collectionService.deleteCollection(_collectionId);
      return true;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return false;
    }
  }
}
