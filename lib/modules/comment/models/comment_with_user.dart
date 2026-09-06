import 'package:cinemate_mobile/core/modules/auth/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_with_user.freezed.dart';
part 'comment_with_user.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    @JsonKey(name: '_id') required String id,
    required String text,
    @JsonKey(name: 'movie_id') required String movieId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
abstract class CommentWithUser with _$CommentWithUser {
  const factory CommentWithUser({
    required Comment comment,
    required User user,
  }) = _CommentWithUser;

  factory CommentWithUser.fromJson(Map<String, dynamic> json) =>
      _$CommentWithUserFromJson(json);
}
