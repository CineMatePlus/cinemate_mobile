import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/user.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    User? user,
    @Default(false) bool isLoading,
    String? error,
  }) = _ProfileState;
}
