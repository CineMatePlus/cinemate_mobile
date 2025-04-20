// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      year: (json['year'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      numLikes: (json['numLikes'] as num).toInt(),
      numWatches: (json['numWatches'] as num).toInt(),
      numRatings: (json['numRatings'] as num).toInt(),
      numComments: (json['numComments'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      type: json['type'] as bool,
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'genres': instance.genres,
      'year': instance.year,
      'averageRating': instance.averageRating,
      'numLikes': instance.numLikes,
      'numWatches': instance.numWatches,
      'numRatings': instance.numRatings,
      'numComments': instance.numComments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'type': instance.type,
    };
