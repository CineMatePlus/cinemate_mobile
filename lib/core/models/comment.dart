import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'content_id') required String contentId,
    @JsonKey(name: 'user_id') required String userId,
    required String text,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    CommentUser? user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  // API yanıtını Comment nesnesine dönüştürmek için
  static Comment fromApiResponse(Map<String, dynamic> response) {
    final commentData = response['comment'] as Map<String, dynamic>;
    final userData = response['user'] as Map<String, dynamic>;

    return Comment(
      id: commentData['_id'] as String,
      contentId: commentData['content_id'] as String,
      userId: commentData['user_id'] as String,
      text: commentData['text'] as String,
      createdAt: DateTime.parse(commentData['created_at'] as String),
      updatedAt: DateTime.parse(commentData['updated_at'] as String),
      user: CommentUser.fromJson(userData),
    );
  }

  // API yanıtlarından Comment nesnelerini liste olarak dönüştürmek için
  static List<Comment> listFromApiResponse(List<dynamic> responseList) {
    return responseList
        .map((item) => Comment.fromApiResponse(item as Map<String, dynamic>))
        .toList();
  }
}

@freezed
class CommentUser with _$CommentUser {
  const factory CommentUser({
    @JsonKey(name: '_id') required String id,
    required String email,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    int? gender,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _CommentUser;

  factory CommentUser.fromJson(Map<String, dynamic> json) =>
      _$CommentUserFromJson(json);
}
