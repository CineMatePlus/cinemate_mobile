import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_user.freezed.dart';
part 'similar_user.g.dart';

@freezed
class SimilarUser with _$SimilarUser {
  const factory SimilarUser({
    @JsonKey(name: '_id') required String id,
    required String email,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required int gender,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required double similarity,
  }) = _SimilarUser;

  factory SimilarUser.fromJson(Map<String, dynamic> json) =>
      _$SimilarUserFromJson(json);
}
