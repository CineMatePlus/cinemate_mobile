// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserContentImpl _$$UserContentImplFromJson(Map<String, dynamic> json) =>
    _$UserContentImpl(
      id: json['_id'] as String?,
      userId: json['user_id'] as String,
      contentId: json['content_id'] as String,
      isLiked: json['is_liked'] as bool?,
      isWatched: json['is_watched'] as bool?,
      isInWatchlist: json['in_watchlist'] as bool?,
      rated: (json['rated'] as num?)?.toInt(),
      lastInteractedAt: json['last_interacted_at'] == null
          ? null
          : DateTime.parse(json['last_interacted_at'] as String),
    );

Map<String, dynamic> _$$UserContentImplToJson(_$UserContentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'content_id': instance.contentId,
      'is_liked': instance.isLiked,
      'is_watched': instance.isWatched,
      'in_watchlist': instance.isInWatchlist,
      'rated': instance.rated,
      'last_interacted_at': instance.lastInteractedAt?.toIso8601String(),
    };
