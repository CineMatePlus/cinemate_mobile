// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserContentImpl _$$UserContentImplFromJson(Map<String, dynamic> json) =>
    _$UserContentImpl(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      contentId: json['content_id'] as String,
      isLiked: json['isLiked'] as bool? ?? false,
      isWatched: json['isWatched'] as bool? ?? false,
      inWatchlist: json['inWatchlist'] as bool? ?? false,
      rated: (json['rated'] as num?)?.toInt(),
      lastInteractedAt: DateTime.parse(json['lastInteractedAt'] as String),
    );

Map<String, dynamic> _$$UserContentImplToJson(_$UserContentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'content_id': instance.contentId,
      'isLiked': instance.isLiked,
      'isWatched': instance.isWatched,
      'inWatchlist': instance.inWatchlist,
      'rated': instance.rated,
      'lastInteractedAt': instance.lastInteractedAt.toIso8601String(),
    };
