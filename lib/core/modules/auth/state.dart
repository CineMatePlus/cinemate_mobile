import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user.dart';
import 'service/service.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

const _unchanged = Object();

class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
  AuthState copyWith({
    AuthStatus? status,
    Object? user = _unchanged,
    Object? errorMessage = _unchanged,
  }) => AuthState(
    status: status ?? this.status,
    user: identical(user, _unchanged) ? this.user : user as User?,
    errorMessage: identical(errorMessage, _unchanged)
        ? this.errorMessage
        : errorMessage as String?,
  );
  factory AuthState.initial() => const AuthState();
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this._authService}) : super(const AuthState()) {
    _authService.onSessionExpired = () {
      if (mounted) state = const AuthState(status: AuthStatus.unauthenticated);
    };
    checkAuthStatus();
  }
  final AuthService _authService;

  Future<void> checkAuthStatus() async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final user = await _authService.refreshTokenAndGetUser();
      if (!mounted) return;
      state = AuthState(
        status: user == null
            ? AuthStatus.unauthenticated
            : AuthStatus.authenticated,
        user: user,
      );
    } catch (error) {
      if (mounted) {
        state = AuthState(
          status: AuthStatus.error,
          errorMessage: error.toString(),
        );
      }
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      setAuthenticated(await _authService.login(email, password));
    } catch (error) {
      if (mounted) {
        state = AuthState(
          status: AuthStatus.error,
          errorMessage: error.toString(),
        );
      }
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    int gender,
  ) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      setAuthenticated(
        await _authService.register(email, name, password, gender),
      );
    } catch (error) {
      if (mounted) {
        state = AuthState(
          status: AuthStatus.error,
          errorMessage: error.toString(),
        );
      }
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (_) {
      // Local logout remains effective even when remote revocation is unreachable.
    } finally {
      if (mounted) state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  void setAuthenticated(User user) {
    if (mounted) {
      state = AuthState(status: AuthStatus.authenticated, user: user);
    }
  }

  @override
  void dispose() {
    _authService.onSessionExpired = null;
    super.dispose();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(authService: ref.watch(authServiceProvider)),
);
