// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Collection _$CollectionFromJson(Map<String, dynamic> json) => _Collection(
  id: json['_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  ownerName: json['owner_name'] as String,
  movieCount: (json['movie_count'] as num?)?.toInt() ?? 0,
  isPublic: json['is_public'] as bool,
  movieIds:
      (json['movie_ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  posterPath: json['posterPath'] as String?,
);

Map<String, dynamic> _$CollectionToJson(_Collection instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'owner_name': instance.ownerName,
      'movie_count': instance.movieCount,
      'is_public': instance.isPublic,
      'movie_ids': instance.movieIds,
      'posterPath': instance.posterPath,
    };
