// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_with_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: json['_id'] as String,
  text: json['text'] as String,
  movieId: json['movie_id'] as String,
  userId: json['user_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  '_id': instance.id,
  'text': instance.text,
  'movie_id': instance.movieId,
  'user_id': instance.userId,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

_CommentWithUser _$CommentWithUserFromJson(Map<String, dynamic> json) =>
    _CommentWithUser(
      comment: Comment.fromJson(json['comment'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentWithUserToJson(_CommentWithUser instance) =>
    <String, dynamic>{'comment': instance.comment, 'user': instance.user};
