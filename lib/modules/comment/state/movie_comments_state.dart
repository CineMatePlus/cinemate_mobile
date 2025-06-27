import 'package:cinemate_mobile/modules/comment/models/comment_with_user.dart';
import 'package:cinemate_mobile/modules/comment/service/comment_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieCommentsProvider = StateNotifierProvider.autoDispose
    .family<MovieCommentsNotifier, AsyncValue<List<CommentWithUser>>, String>(
        (ref, movieId) {
  final commentService = ref.watch(commentServiceProvider);
  return MovieCommentsNotifier(commentService, movieId);
});

class MovieCommentsNotifier
    extends StateNotifier<AsyncValue<List<CommentWithUser>>> {
  final CommentService _commentService;
  final String _movieId;

  MovieCommentsNotifier(this._commentService, this._movieId)
      : super(const AsyncValue.loading()) {
    fetchComments();
  }

  Future<void> fetchComments() async {
    state = const AsyncValue.loading();
    try {
      final comments = await _commentService.getMovieComments(_movieId);
      state = AsyncValue.data(comments);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> postComment(String text) async {
    try {
      final newComment = await _commentService.postComment(_movieId, text);
      state = state.whenData((comments) => [newComment, ...comments]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteComment(String commentId) async {
    // Optimistic update
    final previousState = state;
    state = state.whenData((comments) =>
        comments.where((c) => c.comment.id != commentId).toList());

    try {
      await _commentService.deleteComment(commentId);
    } catch (e) {
      state = previousState; // Revert on error
      rethrow;
    }
  }

  Future<void> updateComment(String commentId, String text) async {
    try {
      final updatedComment =
          await _commentService.updateComment(commentId, text);
      state = state.whenData((comments) => comments
          .map((c) => c.comment.id == commentId ? updatedComment : c)
          .toList());
    } catch (e) {
      rethrow;
    }
  }
}
