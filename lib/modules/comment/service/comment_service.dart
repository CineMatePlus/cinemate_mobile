import 'package:cinemate_mobile/core/modules/auth/state.dart';
import 'package:cinemate_mobile/core/providers/api_service_provider.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/modules/comment/models/comment_with_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentServiceProvider = Provider<CommentService>((ref) {
  ref.watch(authProvider.select((state) => state.user?.id));
  final apiService = ref.watch(apiServiceProvider);
  return CommentService(apiService);
});

class CommentService {
  final ApiService _apiService;

  CommentService(this._apiService);

  Future<List<CommentWithUser>> getMovieComments(
    String movieId, {
    int skip = 0,
    int limit = 10,
  }) async {
    final response = await _apiService.request(
      'GET',
      '/comments/$movieId?skip=$skip&limit=$limit',
    );
    return (response.data as List)
        .map((comment) => CommentWithUser.fromJson(comment))
        .toList();
  }

  Future<CommentWithUser> postComment(String movieId, String text) async {
    final response = await _apiService.request(
      'POST',
      '/comments/$movieId',
      data: {'text': text},
    );
    return CommentWithUser.fromJson(response.data);
  }

  Future<CommentWithUser> updateComment(String commentId, String text) async {
    final response = await _apiService.request(
      'PUT',
      '/comments/$commentId',
      data: {'text': text},
    );
    return CommentWithUser.fromJson(response.data);
  }

  Future<void> deleteComment(String commentId) async {
    await _apiService.request('DELETE', '/comments/$commentId');
  }

  Future<List<CommentWithUser>> getMyComments({
    int skip = 0,
    int limit = 10,
  }) async {
    final response = await _apiService.request(
      'GET',
      '/comments/user/me?skip=$skip&limit=$limit',
    );
    return (response.data as List)
        .map((comment) => CommentWithUser.fromJson(comment))
        .toList();
  }
}
