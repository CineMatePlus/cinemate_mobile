import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const factory Content({
    String? id,
    String? title,
    String? description,
    List<String>? genres,
    int? year,
    double? averageRating,
    int? numLikes,
    int? numWatches,
    int? numRatings,
    int? numComments,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? type, // true: dizi, false: film
    String? imageUrl,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
