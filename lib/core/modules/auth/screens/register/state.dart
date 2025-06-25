import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state.dart';
import '../../service/service.dart';

class RegisterState {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final int? gender;
  final bool isLoading;
  final String? errorMessage;
  final GlobalKey<FormState> formKey;

  RegisterState({
    this.name = 'Muhammet Berk Can',
    this.email = 'berk@torolimited.com',
    this.phone = '',
    this.password = 'asdasd',
    this.confirmPassword = 'asdasd',
    this.gender,
    this.isLoading = false,
    this.errorMessage,
    GlobalKey<FormState>? formKey,
  }) : formKey = formKey ?? GlobalKey<FormState>();

  RegisterState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    int? gender,
    bool? isLoading,
    String? errorMessage,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      formKey: formKey ?? this.formKey,
    );
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthNotifier _authNotifier;
  final AuthService _authService;

  RegisterNotifier({
    required AuthNotifier authNotifier,
    required AuthService authService,
  })  : _authNotifier = authNotifier,
        _authService = authService,
        super(RegisterState());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  void setGender(int gender) {
    state = state.copyWith(gender: gender);
  }

  void resetForm() {
    state = RegisterState(formKey: state.formKey);
  }

  Future<void> register() async {
    if (!state.formKey.currentState!.validate()) return;

    // Telefon numarası boş olamaz
    if (state.phone.isEmpty || state.phone.length < 10) {
      state = state.copyWith(
          errorMessage: 'Lütfen geçerli bir telefon numarası giriniz.');
      return;
    }

    // Cinsiyet seçimi zorunlu
    if (state.gender == null) {
      state = state.copyWith(errorMessage: 'Lütfen bir cinsiyet seçiniz.');
      return;
    }

    // Şifre eşleşme kontrolü
    if (state.password != state.confirmPassword) {
      state = state.copyWith(
        errorMessage: 'Şifreler eşleşmiyor.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // AuthService'i direkt kullan, auth state'i etkilemesin
      final user = await _authService.register(
          state.name, state.email, state.password, state.gender ?? 2);

      // Başarılı kayıt - auth state'i güncelle
      _authNotifier.state = _authNotifier.state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        errorMessage: null,
      );

      // Formu sıfırla
      resetForm();
    } catch (e) {
      // Error durumunda sadece local state'i güncelle, auth state'i dokunma
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  return RegisterNotifier(
    authNotifier: authNotifier,
    authService: ref.read(authServiceProvider),
  );
});
