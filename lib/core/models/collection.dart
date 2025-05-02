import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

@freezed
class Collection with _$Collection {
  const factory Collection({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'user_id') String? userId,
    String? title,
    @JsonKey(name: 'is_public') @Default(false) bool? isPublic,
    @JsonKey(name: 'content_ids') List<String>? contentIds,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
