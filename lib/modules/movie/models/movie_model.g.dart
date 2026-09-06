// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Movie _$MovieFromJson(Map<String, dynamic> json) => _Movie(
  id: json['_id'] as String,
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  voteAverage: (json['vote_average'] as num).toDouble(),
  releaseDate: json['release_date'] as String,
  genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
  numLikes: (json['num_likes'] as num).toInt(),
  numWatches: (json['num_watches'] as num).toInt(),
  isLiked: json['is_liked'] as bool,
  isWatched: json['is_watched'] as bool,
  isInWatchlist: json['is_in_watchlist'] as bool,
);

Map<String, dynamic> _$MovieToJson(_Movie instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'overview': instance.overview,
  'poster_path': instance.posterPath,
  'backdrop_path': instance.backdropPath,
  'vote_average': instance.voteAverage,
  'release_date': instance.releaseDate,
  'genres': instance.genres,
  'num_likes': instance.numLikes,
  'num_watches': instance.numWatches,
  'is_liked': instance.isLiked,
  'is_watched': instance.isWatched,
  'is_in_watchlist': instance.isInWatchlist,
};
