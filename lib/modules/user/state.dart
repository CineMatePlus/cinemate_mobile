import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemate_mobile/core/utils/utils.dart';
import 'package:cinemate_mobile/core/models/user.dart';

// State'ler için enum
enum UserStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

// User state modeli
class UserState {
  final UserStatus status;
  final User? user;
  final String? token;
  final String? error;

  const UserState({
    this.status = UserStatus.initial,
    this.user,
    this.token,
    this.error,
  });

  UserState copyWith({
    UserStatus? status,
    User? user,
    String? token,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }
}

// User state notifier
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState()) {
    checkAuth();
  }

  // Auth durumunu kontrol et
  Future<void> checkAuth() async {
    try {
      state = state.copyWith(status: UserStatus.loading);
      final token = await SecureStorageUtils.getToken();

      if (token == null) {
        state = state.copyWith(
          status: UserStatus.unauthenticated,
          user: null,
          token: null,
        );
        return;
      }

      state = state.copyWith(
        status: UserStatus.authenticated,
        token: token,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        error: e.toString(),
        token: null,
      );
    }
  }

  // Kullanıcı bilgilerini ve token'ı ayarla
  Future<void> login(User user, String token) async {
    try {
      await SecureStorageUtils.saveToken(token);
      state = state.copyWith(
        status: UserStatus.authenticated,
        user: user,
        token: token,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        error: e.toString(),
      );
    }
  }

  // Çıkış yap
  Future<void> logout() async {
    try {
      state = state.copyWith(status: UserStatus.loading);
      await SecureStorageUtils.deleteToken();

      state = state.copyWith(
        status: UserStatus.unauthenticated,
        user: null,
        token: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        error: e.toString(),
      );
    }
  }
}

// Provider'lar
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
