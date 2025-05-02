import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/collection.dart';
import '../../../../core/models/content.dart';
import 'service/collection_service.dart';
import '../../../../core/services/api_service.dart';

final collectionServiceProvider = Provider<CollectionService>((ref) {
  final apiService = ApiService();
  return CollectionService(apiService);
});

/// Kullanıcının koleksiyonlarını yöneten provider
final userCollectionsProvider =
    StateNotifierProvider<CollectionsNotifier, AsyncValue<List<Collection>>>(
        (ref) {
  final service = ref.watch(collectionServiceProvider);
  return CollectionsNotifier(service);
});

/// Belirli bir koleksiyonun içeriklerini yöneten provider
final collectionContentsProvider = StateNotifierProvider.family<
    CollectionContentsNotifier,
    AsyncValue<List<Content>>,
    String>((ref, collectionId) {
  final service = ref.watch(collectionServiceProvider);
  return CollectionContentsNotifier(service, collectionId);
});

class CollectionsNotifier extends StateNotifier<AsyncValue<List<Collection>>> {
  final CollectionService _service;
  static const int _pageSize = 10;
  int _skip = 0;
  bool _hasMore = true;

  CollectionsNotifier(this._service) : super(const AsyncValue.loading()) {
    loadCollections();
  }

  Future<void> loadCollections({bool refresh = false}) async {
    if (refresh) {
      _skip = 0;
      _hasMore = true;
      state = const AsyncValue.loading();
    } else if (!_hasMore) {
      return;
    }

    try {
      final newItems = await _service.getUserCollections(
        skip: _skip,
        limit: _pageSize,
      );

      if (newItems.isEmpty) {
        _hasMore = false;
        return;
      }

      _skip += newItems.length;

      state = AsyncValue.data(
        refresh ? newItems : [...state.asData?.value ?? [], ...newItems],
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createCollection({
    required String title,
    bool isPublic = false,
    List<String> contentIds = const [],
  }) async {
    try {
      final newCollection = await _service.createCollection(
        title: title,
        isPublic: isPublic,
        contentIds: contentIds,
      );

      // Koleksiyonu listenin başına ekle
      state = AsyncValue.data([newCollection, ...state.asData?.value ?? []]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteCollection(String collectionId) async {
    try {
      await _service.deleteCollection(collectionId);

      // Silineni listeden çıkar
      state = AsyncValue.data(
        state.asData?.value.where((col) => col.id != collectionId).toList() ??
            [],
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateCollection({
    required String collectionId,
    String? title,
    bool? isPublic,
  }) async {
    try {
      final updatedCollection = await _service.updateCollection(
        collectionId: collectionId,
        title: title,
        isPublic: isPublic,
      );

      // Koleksiyonu listede güncelle
      state = AsyncValue.data(
        state.asData?.value.map((col) {
              return col.id == collectionId ? updatedCollection : col;
            }).toList() ??
            [],
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

class CollectionContentsNotifier
    extends StateNotifier<AsyncValue<List<Content>>> {
  final CollectionService _service;
  final String _collectionId;
  static const int _pageSize = 10;
  int _skip = 0;
  bool _hasMore = true;

  CollectionContentsNotifier(this._service, this._collectionId)
      : super(const AsyncValue.loading()) {
    // Constructor içinde loadContents çağrılmamalı, kullanıcı arayüzünden tetiklenmeli
    // Bu sayede sayfa açıldığında içeriğin yüklenmesi garantilenir
  }

  Future<void> loadContents({bool refresh = false}) async {
    if (!refresh && (state.isLoading || state is AsyncLoading)) {
      return; // Zaten yükleme yapılıyorsa tekrar başlatma
    }

    if (refresh) {
      _skip = 0;
      _hasMore = true;
      state = const AsyncValue.loading();
    } else if (!_hasMore) {
      return;
    }

    try {
      final newItems = await _service.getCollectionContents(
        _collectionId,
        skip: _skip,
        limit: _pageSize,
      );

      if (newItems.isEmpty) {
        _hasMore = false;
        return;
      }

      _skip += newItems.length;

      state = AsyncValue.data(
        refresh ? newItems : [...state.asData?.value ?? [], ...newItems],
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addContent(String contentId) async {
    try {
      await _service.addContentToCollection(_collectionId, contentId);
      // İçerik ekledikten sonra listeyi yenile
      loadContents(refresh: true);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeContent(String contentId) async {
    try {
      await _service.removeContentFromCollection(_collectionId, contentId);

      // İçeriği listeden çıkar
      state = AsyncValue.data(
        state.asData?.value
                .where((content) => content.id != contentId)
                .toList() ??
            [],
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
