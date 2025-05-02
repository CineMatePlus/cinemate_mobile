import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/content.dart';
import 'user_content_service.dart';
import '../../core/services/api_service.dart';

final userContentListServiceProvider = Provider<UserContentService>((ref) {
  final apiService = ApiService();
  return UserContentService(apiService);
});

final userContentListProvider =
    StateNotifierProvider<UserContentListNotifier, Map<String, List<Content>>>(
        (ref) {
  final service = ref.watch(userContentListServiceProvider);
  return UserContentListNotifier(service);
});

class UserContentListNotifier
    extends StateNotifier<Map<String, List<Content>>> {
  final UserContentService _service;
  static const int _pageSize = 10;

  UserContentListNotifier(this._service)
      : super({
          'liked': [],
          'watched': [],
          'watchlist': [],
        });

  Future<void> loadLikedContents({bool refresh = false}) async {
    if (refresh) {
      state = {...state, 'liked': []};
    }

    final currentList = state['liked'] ?? [];
    final skip = currentList.length;

    final newItems = await _service.getLikedContents(
      skip: skip,
      limit: _pageSize,
    );

    state = {
      ...state,
      'liked': [...currentList, ...newItems],
    };
  }

  Future<void> loadWatchHistory({bool refresh = false}) async {
    if (refresh) {
      state = {...state, 'watched': []};
    }

    final currentList = state['watched'] ?? [];
    final skip = currentList.length;

    final newItems = await _service.getWatchHistory(
      skip: skip,
      limit: _pageSize,
    );

    state = {
      ...state,
      'watched': [...currentList, ...newItems],
    };
  }

  Future<void> loadWatchlist({bool refresh = false}) async {
    if (refresh) {
      state = {...state, 'watchlist': []};
    }

    final currentList = state['watchlist'] ?? [];
    final skip = currentList.length;

    final newItems = await _service.getWatchlist(
      skip: skip,
      limit: _pageSize,
    );

    state = {
      ...state,
      'watchlist': [...currentList, ...newItems],
    };
  }

  Future<void> toggleLike(String contentId) async {
    final result = await _service.toggleLike(contentId);

    // Beğenilen içerikler listesini güncelle
    final likedList = state['liked'] ?? [];
    if (result.isLiked ?? false) {
      if (!likedList.any((item) => item.id == contentId)) {
        // Eğer içerik zaten yüklenmiş ise onu bul
        final content = _findContentInLists(contentId);
        if (content != null) {
          state = {
            ...state,
            'liked': [content, ...likedList],
          };
        } else {
          // İçerik daha önce yüklenmemiş, API'den tekrar yükle
          await refreshLists(contentId);
        }
      }
    } else {
      state = {
        ...state,
        'liked': likedList.where((item) => item.id != contentId).toList(),
      };
    }
  }

  Future<void> toggleWatch(String contentId) async {
    final result = await _service.toggleWatch(contentId);

    // İzlenen içerikler listesini güncelle
    final watchedList = state['watched'] ?? [];
    if (result.isWatched ?? false) {
      if (!watchedList.any((item) => item.id == contentId)) {
        // Eğer içerik zaten yüklenmiş ise onu bul
        final content = _findContentInLists(contentId);
        if (content != null) {
          state = {
            ...state,
            'watched': [content, ...watchedList],
          };
        } else {
          // İçerik daha önce yüklenmemiş, API'den tekrar yükle
          await refreshLists(contentId);
        }
      }
    } else {
      state = {
        ...state,
        'watched': watchedList.where((item) => item.id != contentId).toList(),
      };
    }
  }

  Future<void> toggleWatchlist(String contentId) async {
    final result = await _service.toggleWatchlist(contentId);

    // İzlenecekler listesini güncelle
    final watchlist = state['watchlist'] ?? [];
    if (result.isInWatchlist ?? false) {
      if (!watchlist.any((item) => item.id == contentId)) {
        // Eğer içerik zaten yüklenmiş ise onu bul
        final content = _findContentInLists(contentId);
        if (content != null) {
          state = {
            ...state,
            'watchlist': [content, ...watchlist],
          };
        } else {
          // İçerik daha önce yüklenmemiş, API'den tekrar yükle
          await refreshLists(contentId);
        }
      }
    } else {
      state = {
        ...state,
        'watchlist': watchlist.where((item) => item.id != contentId).toList(),
      };
    }
  }

  // İçeriği mevcut listelerden bul
  Content? _findContentInLists(String contentId) {
    // Önce tüm listelerden ara
    for (final list in state.values) {
      final content = list.firstWhere(
        (content) => content.id == contentId,
        orElse: () => Content(id: null),
      );
      if (content.id != null) {
        return content;
      }
    }
    return null;
  }

  // İçeriği etkileyebilecek listeleri yenile
  Future<void> refreshLists(String contentId) async {
    await loadLikedContents(refresh: true);
    await loadWatchHistory(refresh: true);
    await loadWatchlist(refresh: true);
  }
}
