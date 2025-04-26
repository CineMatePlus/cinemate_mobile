import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_content.freezed.dart';
part 'user_content.g.dart';

@freezed
class UserContent with _$UserContent {
  const factory UserContent({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'content_id') required String contentId,
    @JsonKey(name: 'is_liked') bool? isLiked,
    @JsonKey(name: 'is_watched') bool? isWatched,
    @JsonKey(name: 'in_watchlist') bool? isInWatchlist,
    @JsonKey(name: 'rated') int? rated,
    @JsonKey(name: 'last_interacted_at') DateTime? lastInteractedAt,
  }) = _UserContent;

  factory UserContent.fromJson(Map<String, dynamic> json) =>
      _$UserContentFromJson(json);
}
