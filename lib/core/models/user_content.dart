import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_content.freezed.dart';
part 'user_content.g.dart';

@freezed
class UserContent with _$UserContent {
  const factory UserContent({
    required String id,
    required String userId,
    required String contentId,
    @Default(false) bool isLiked,
    @Default(false) bool isWatched,
    @Default(false) bool inWatchlist,
    int? rated,
    required DateTime lastInteractedAt,
  }) = _UserContent;

  factory UserContent.fromJson(Map<String, dynamic> json) =>
      _$UserContentFromJson(json);
}
