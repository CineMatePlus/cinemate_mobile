// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      year: (json['year'] as num?)?.toInt(),
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      numLikes: (json['num_likes'] as num?)?.toInt(),
      numWatches: (json['num_watches'] as num?)?.toInt(),
      numRatings: (json['num_ratings'] as num?)?.toInt(),
      numComments: (json['num_comments'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      type: json['type'] as bool?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'genres': instance.genres,
      'year': instance.year,
      'average_rating': instance.averageRating,
      'num_likes': instance.numLikes,
      'num_watches': instance.numWatches,
      'num_ratings': instance.numRatings,
      'num_comments': instance.numComments,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'type': instance.type,
      'image_url': instance.imageUrl,
    };
