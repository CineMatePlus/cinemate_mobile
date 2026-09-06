// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimilarUser _$SimilarUserFromJson(Map<String, dynamic> json) => _SimilarUser(
  id: json['_id'] as String,
  email: json['email'] as String? ?? '',
  name: json['name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  gender: (json['gender'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  similarity: (json['similarity'] as num).toDouble(),
);

Map<String, dynamic> _$SimilarUserToJson(_SimilarUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'gender': instance.gender,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'similarity': instance.similarity,
    };
