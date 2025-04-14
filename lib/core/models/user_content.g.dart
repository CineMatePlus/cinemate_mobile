// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserContentImpl _$$UserContentImplFromJson(Map<String, dynamic> json) =>
    _$UserContentImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      contentId: json['contentId'] as String,
      isLiked: json['isLiked'] as bool? ?? false,
      isWatched: json['isWatched'] as bool? ?? false,
      inWatchlist: json['inWatchlist'] as bool? ?? false,
      rated: (json['rated'] as num?)?.toInt(),
      lastInteractedAt: DateTime.parse(json['lastInteractedAt'] as String),
    );

Map<String, dynamic> _$$UserContentImplToJson(_$UserContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'contentId': instance.contentId,
      'isLiked': instance.isLiked,
      'isWatched': instance.isWatched,
      'inWatchlist': instance.inWatchlist,
      'rated': instance.rated,
      'lastInteractedAt': instance.lastInteractedAt.toIso8601String(),
    };
