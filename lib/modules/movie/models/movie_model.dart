import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'release_date') required String releaseDate,
    required List<String> genres,
    @JsonKey(name: 'num_likes') required int numLikes,
    @JsonKey(name: 'num_watches') required int numWatches,
    @JsonKey(name: 'is_liked') required bool isLiked,
    @JsonKey(name: 'is_watched') required bool isWatched,
    @JsonKey(name: 'is_in_watchlist') required bool isInWatchlist,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
