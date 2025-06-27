import 'package:cinemate_mobile/modules/comment/models/comment_with_user.dart';
import 'package:cinemate_mobile/modules/comment/service/comment_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myCommentsProvider = StateNotifierProvider.autoDispose<MyCommentsNotifier,
    AsyncValue<List<CommentWithUser>>>((ref) {
  final commentService = ref.watch(commentServiceProvider);
  return MyCommentsNotifier(commentService);
});

class MyCommentsNotifier
    extends StateNotifier<AsyncValue<List<CommentWithUser>>> {
  final CommentService _commentService;

  MyCommentsNotifier(this._commentService) : super(const AsyncValue.loading()) {
    fetchMyComments();
  }

  Future<void> fetchMyComments() async {
    state = const AsyncValue.loading();
    try {
      final comments = await _commentService.getMyComments();
      state = AsyncValue.data(comments);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
