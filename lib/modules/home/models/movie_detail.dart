import 'package:freezed_annotation/freezed_annotation.dart';
import 'movie.dart';

part 'movie_detail.freezed.dart';
part 'movie_detail.g.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required Movie movie,
    required String director,
    required List<String> cast,
    required int runtime,
    required List<String> languages,
    required List<String> countries,
    required String tagline,
    required String budget,
    required String revenue,
  }) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);
}
