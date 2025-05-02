import '../../core/models/user_content.dart';
import '../../core/models/content.dart';
import '../../core/services/api_service.dart';

class UserContentService {
  final ApiService _apiService;

  UserContentService(this._apiService);

  Future<UserContent> getUserContentStatus(String contentId) async {
    final response = await _apiService.request(
      'GET',
      '/user-contents/$contentId/status',
    );
    return UserContent.fromJson(response.data);
  }

  Future<List<Content>> getWatchHistory({int skip = 0, int limit = 10}) async {
    final response = await _apiService.request(
      'GET',
      '/user-contents/watch-history',
      data: {
        'skip': skip,
        'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => Content.fromJson(json))
        .toList();
  }

  Future<List<Content>> getWatchlist({int skip = 0, int limit = 10}) async {
    final response = await _apiService.request(
      'GET',
      '/user-contents/watchlist',
      data: {
        'skip': skip,
        'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => Content.fromJson(json))
        .toList();
  }

  Future<List<Content>> getLikedContents({int skip = 0, int limit = 10}) async {
    final response = await _apiService.request(
      'GET',
      '/user-contents/liked',
      data: {
        'skip': skip,
        'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => Content.fromJson(json))
        .toList();
  }

  Future<UserContent> toggleLike(String contentId) async {
    final response = await _apiService.request(
      'POST',
      '/user-contents/$contentId/like',
    );
    return UserContent.fromJson(response.data);
  }

  Future<UserContent> toggleWatch(String contentId) async {
    final response = await _apiService.request(
      'POST',
      '/user-contents/$contentId/watch',
    );
    return UserContent.fromJson(response.data);
  }

  Future<UserContent> toggleWatchlist(String contentId) async {
    final response = await _apiService.request(
      'POST',
      '/user-contents/$contentId/watchlist',
    );
    return UserContent.fromJson(response.data);
  }
}
