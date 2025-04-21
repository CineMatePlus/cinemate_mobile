import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const factory Content({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? description,
    List<String>? genres,
    int? year,
    @JsonKey(name: 'average_rating') double? averageRating,
    @JsonKey(name: 'num_likes') int? numLikes,
    @JsonKey(name: 'num_watches') int? numWatches,
    @JsonKey(name: 'num_ratings') int? numRatings,
    @JsonKey(name: 'num_comments') int? numComments,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    bool? type, // true: dizi, false: film
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
