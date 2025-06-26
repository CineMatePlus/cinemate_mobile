import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_model.freezed.dart';
part 'collection_model.g.dart';

@freezed
class Collection with _$Collection {
  const factory Collection({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String description,
    @JsonKey(name: 'owner_name') required String ownerName,
    @JsonKey(name: 'movie_count') @Default(0) int movieCount,
    @JsonKey(name: 'is_public') required bool isPublic,
    @JsonKey(name: 'movie_ids') @Default([]) List<String> movieIds,
    // Assuming a collection might have a poster/backdrop image from user selection
    String? posterPath,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
