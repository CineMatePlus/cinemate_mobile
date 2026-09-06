import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../state.dart';
import '../../service/service.dart';

part 'state.freezed.dart';

@freezed
abstract class RegisterState with _$RegisterState {
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
  final AuthNotifier _authNotifier;

  RegisterNotifier(AuthService authService, this._authNotifier)
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
      await _authNotifier.register(
        state.name,
        state.email,
        state.password,
        state.gender,
      );
    } catch (e) {
      // Hata yönetimi burada yapılabilir, örneğin bir SnackBar göstermek.
      debugPrint('Register failed: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
