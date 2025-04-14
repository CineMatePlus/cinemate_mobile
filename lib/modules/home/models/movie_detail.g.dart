// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieDetailImpl _$$MovieDetailImplFromJson(Map<String, dynamic> json) =>
    _$MovieDetailImpl(
      movie: Movie.fromJson(json['movie'] as Map<String, dynamic>),
      director: json['director'] as String,
      cast: (json['cast'] as List<dynamic>).map((e) => e as String).toList(),
      runtime: (json['runtime'] as num).toInt(),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      countries:
          (json['countries'] as List<dynamic>).map((e) => e as String).toList(),
      tagline: json['tagline'] as String,
      budget: json['budget'] as String,
      revenue: json['revenue'] as String,
    );

Map<String, dynamic> _$$MovieDetailImplToJson(_$MovieDetailImpl instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'director': instance.director,
      'cast': instance.cast,
      'runtime': instance.runtime,
      'languages': instance.languages,
      'countries': instance.countries,
      'tagline': instance.tagline,
      'budget': instance.budget,
      'revenue': instance.revenue,
    };
