import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state.dart';

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final GlobalKey<FormState> formKey;

  LoginState({
    this.email = 'string@gmail.com',
    this.password = 'string',
    this.isLoading = false,
    this.errorMessage,
    GlobalKey<FormState>? formKey,
  }) : formKey = formKey ?? GlobalKey<FormState>();

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      formKey: formKey ?? this.formKey,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthNotifier _authNotifier;

  LoginNotifier({required AuthNotifier authNotifier})
      : _authNotifier = authNotifier,
        super(LoginState());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void resetForm() {
    state = LoginState(formKey: state.formKey);
  }

  Future<void> login() async {
    if (!state.formKey.currentState!.validate()) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _authNotifier.login(state.email, state.password);

      // Auth state'deki durumu kontrol et
      // Hata varsa, login state'e ekle
      final authState = _authNotifier.state;
      if (authState.status == AuthStatus.error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: authState.errorMessage,
        );
      } else {
        // Başarılı giriş, formu sıfırla
        resetForm();
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  return LoginNotifier(authNotifier: authNotifier);
});
