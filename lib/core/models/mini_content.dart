import 'package:freezed_annotation/freezed_annotation.dart';

part 'mini_content.freezed.dart';
part 'mini_content.g.dart';

@freezed
class MiniContent with _$MiniContent {
  const factory MiniContent({
    required String title,
    required int year,
    @JsonKey(name: 'num_likes') required int numLikes,
  }) = _MiniContent;

  factory MiniContent.fromJson(Map<String, dynamic> json) =>
      _$MiniContentFromJson(json);
}
