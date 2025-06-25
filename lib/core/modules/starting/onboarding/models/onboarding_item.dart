import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_item.freezed.dart';
part 'onboarding_item.g.dart';

@freezed
abstract class OnboardingItem with _$OnboardingItem {
  const factory OnboardingItem({
    required String title,
    required String subtitle,
    required String image,
  }) = _OnboardingItem;

  factory OnboardingItem.fromJson(Map<String, dynamic> json) =>
      _$OnboardingItemFromJson(json);
}
