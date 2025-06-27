import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user.dart';
import 'service/service.dart';

// Auth State
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  // State kopyalama metodu
  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      //NOTE: burada `errorMessage: errorMessage` şeklinde yazılırsa testlerde hata alınıyor. çünkü errorMessage null oluyor.
      //TODO: projenin geri kalanında da buna dikkat etmek gerekiyor.
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // İlk state
  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.initial,
      user: null,
      errorMessage: null,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier({required AuthService authService})
      : _authService = authService,
        super(AuthState.initial()) {
    // Başlangıçta mevcut oturum durumunu kontrol et
    checkAuthStatus();
  }

  // Oturum durumunu kontrol et
  Future<void> checkAuthStatus() async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await _authService.refreshTokenAndGetUser();

      if (user != null) {
        // Token geçerli ve kullanıcı bilgileri alındı
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          errorMessage: null,
        );
      } else {
        // Token yok veya geçersiz
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  // Giriş işlemi
  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await _authService.login(email, password);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // Kayıt işlemi
  Future<void> register(
      String name, String email, String password, int gender) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await _authService.register(name, email, password, gender);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // Çıkış işlemi
  Future<void> logout() async {
    //state = state.copyWith(status: AuthStatus.loading);

    try {
      log("Çıkış işlemi başlatıldı: ${state.status}, ${state.user}",
          name: "AuthNotifier");
      await _authService.logout();
      //NOTE: burada state.copyWith kullanmıyoruz çünkü user ve errorMessage null kaydetmiyor.
      state = const AuthState(
        status: AuthStatus.unauthenticated,
        user: null,
        errorMessage: null,
      );
      log("Çıkış işlemi başarılı: ${state.status}, ${state.user}",
          name: "AuthNotifier");
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void setAuthenticated(User user) {
    state = state.copyWith(
        status: AuthStatus.authenticated, user: user, errorMessage: null);
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService: authService);
});
