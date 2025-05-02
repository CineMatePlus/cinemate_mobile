import '../../../../../core/models/collection.dart';
import '../../../../../core/models/content.dart';
import '../../../../../core/services/api_service.dart';

class CollectionService {
  final ApiService _apiService;

  CollectionService(this._apiService);

  /// Kullanıcının koleksiyonlarını getirir
  Future<List<Collection>> getUserCollections(
      {int skip = 0, int limit = 10}) async {
    final response = await _apiService.request(
      'GET',
      '/collections',
      data: {
        'skip': skip,
        'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => Collection.fromJson(json))
        .toList();
  }

  /// Belirli bir koleksiyondaki içerikleri getirir
  Future<List<Content>> getCollectionContents(String collectionId,
      {int skip = 0, int limit = 10}) async {
    final response = await _apiService.request(
      'GET',
      '/collections/$collectionId',
      data: {
        'skip': skip,
        'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => Content.fromJson(json))
        .toList();
  }

  /// Yeni bir koleksiyon oluşturur
  Future<Collection> createCollection({
    required String title,
    bool isPublic = false,
    List<String> contentIds = const [],
  }) async {
    final response = await _apiService.request(
      'POST',
      '/collections',
      data: {
        'title': title,
        'isPublic': isPublic,
        'contentIds': contentIds,
      },
    );
    return Collection.fromJson(response.data);
  }

  /// Bir koleksiyonu günceller
  Future<Collection> updateCollection({
    required String collectionId,
    String? title,
    bool? isPublic,
    List<String>? contentIds,
  }) async {
    final Map<String, dynamic> data = {};

    if (title != null) data['title'] = title;
    if (isPublic != null) data['isPublic'] = isPublic;
    if (contentIds != null) data['contentIds'] = contentIds;

    final response = await _apiService.request(
      'PUT',
      '/collections/$collectionId',
      data: data,
    );
    return Collection.fromJson(response.data);
  }

  /// Bir koleksiyonu siler
  Future<void> deleteCollection(String collectionId) async {
    await _apiService.request(
      'DELETE',
      '/collections/$collectionId',
    );
  }

  /// Bir koleksiyona içerik ekler
  Future<Collection> addContentToCollection(
      String collectionId, String contentId) async {
    final response = await _apiService.request(
      'POST',
      '/collections/$collectionId/contents',
      data: {
        'contentId': contentId,
      },
    );
    return Collection.fromJson(response.data);
  }

  /// Bir koleksiyondan içerik çıkarır
  Future<Collection> removeContentFromCollection(
      String collectionId, String contentId) async {
    final response = await _apiService.request(
      'DELETE',
      '/collections/$collectionId/contents/$contentId',
    );
    return Collection.fromJson(response.data);
  }
}
