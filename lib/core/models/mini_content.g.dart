// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MiniContentImpl _$$MiniContentImplFromJson(Map<String, dynamic> json) =>
    _$MiniContentImpl(
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      numLikes: (json['num_likes'] as num).toInt(),
    );

Map<String, dynamic> _$$MiniContentImplToJson(_$MiniContentImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'num_likes': instance.numLikes,
    };
