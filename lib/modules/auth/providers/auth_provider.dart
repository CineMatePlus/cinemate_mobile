import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../states/auth_state.dart';
import '../services/auth_service.dart';
import 'auth_service_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  late final AuthService _authService;

  @override
  Future<AuthState> build() async {
    _authService = ref.read(authServiceProvider);
    return const AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _authService.login(email, password);
      return AuthState.authenticated(user);
    });
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _authService.register(name, email, password);
      return AuthState.authenticated(user);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authService.logout();
      return const AuthState.unauthenticated();
    });
  }

  Future<void> checkAuthStatus() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final user = await _authService.getCurrentUser();
        return AuthState.authenticated(user);
      } catch (e) {
        return const AuthState.unauthenticated();
      }
    });
  }
}
