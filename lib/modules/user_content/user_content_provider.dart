import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/user_content.dart';
import 'user_content_service.dart';
import '../../core/services/api_service.dart';

final userContentServiceProvider = Provider<UserContentService>((ref) {
  final apiService = ApiService();
  return UserContentService(apiService);
});

final userContentProvider =
    StateNotifierProvider<UserContentNotifier, UserContent?>((ref) {
  final service = ref.watch(userContentServiceProvider);
  return UserContentNotifier(service);
});

class UserContentNotifier extends StateNotifier<UserContent?> {
  final UserContentService _service;

  UserContentNotifier(this._service) : super(null);

  Future<void> loadUserContentStatus(String contentId) async {
    final result = await _service.getUserContentStatus(contentId);
    state = result;
  }

  Future<void> toggleLike(String contentId) async {
    final result = await _service.toggleLike(contentId);
    state = result;
  }

  Future<void> toggleWatch(String contentId) async {
    final result = await _service.toggleWatch(contentId);
    state = result;
  }

  Future<void> toggleWatchlist(String contentId) async {
    final result = await _service.toggleWatchlist(contentId);
    state = result;
  }
}
