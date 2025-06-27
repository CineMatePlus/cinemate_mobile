import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../state.dart';
import '../../service/service.dart';

part 'state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default(2) int gender, // Varsayılan olarak 'Diğer'
    @Default(false) bool isLoading,
    GlobalKey<FormState>? formKey,
  }) = _RegisterState;
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final authNotifier = ref.read(authProvider.notifier);
  return RegisterNotifier(authService, authNotifier);
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthService _authService;
  final AuthNotifier _authNotifier;

  RegisterNotifier(this._authService, this._authNotifier)
      : super(RegisterState(formKey: GlobalKey<FormState>()));

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setGender(int gender) {
    state = state.copyWith(gender: gender);
  }

  Future<void> register() async {
    if (!state.formKey!.currentState!.validate()) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.register(
        state.email,
        state.name,
        state.password,
        state.gender,
      );
      _authNotifier.setAuthenticated(user);
    } catch (e) {
      // Hata yönetimi burada yapılabilir, örneğin bir SnackBar göstermek.
      debugPrint('Register failed: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
