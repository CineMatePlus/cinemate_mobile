import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const factory Content({
    required String id,
    required String title,
    required String description,
    required List<String> genres,
    required int year,
    required double averageRating,
    required int numLikes,
    required int numWatches,
    required int numRatings,
    required int numComments,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
