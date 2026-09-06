import 'package:cinemate_mobile/modules/collections/models/collection_model.dart';
import 'package:cinemate_mobile/modules/collections/service/collection_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class CollectionsListState with _$CollectionsListState {
  const factory CollectionsListState({
    @Default([]) List<Collection> collections,
  }) = _CollectionsListState;
}

final collectionsListProvider =
    StateNotifierProvider.autoDispose<
      CollectionsListNotifier,
      AsyncValue<CollectionsListState>
    >((ref) {
      final collectionService = ref.watch(collectionServiceProvider);
      return CollectionsListNotifier(collectionService);
    });

class CollectionsListNotifier
    extends StateNotifier<AsyncValue<CollectionsListState>> {
  final CollectionService _collectionService;

  CollectionsListNotifier(this._collectionService)
    : super(const AsyncValue.loading()) {
    fetchCollections();
  }

  Future<void> fetchCollections() async {
    state = const AsyncValue.loading();
    try {
      final collections = await _collectionService.getMyCollections();
      if (!mounted) return;
      state = AsyncValue.data(CollectionsListState(collections: collections));
    } catch (e, s) {
      if (!mounted) return;
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> createCollection({
    required String name,
    required String description,
    required bool isPublic,
  }) async {
    try {
      final newCollection = await _collectionService.createCollection(
        name: name,
        description: description,
        isPublic: isPublic,
      );

      // Add the new collection to the beginning of the list
      state.whenData((currentState) {
        final updatedCollections = [newCollection, ...currentState.collections];
        if (!mounted) return;
        state = AsyncValue.data(
          CollectionsListState(collections: updatedCollections),
        );
      });
    } catch (e, s) {
      // Handle error - you might want to show a snackbar or dialog
      if (!mounted) return;
      state = AsyncValue.error(e, s);
    }
  }
}
