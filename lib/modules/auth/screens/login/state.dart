import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemate_mobile/modules/auth/service/service.dart';
import 'package:cinemate_mobile/modules/auth/state.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState {
  final LoginStatus status;
  final String? error;
  final String email;
  final String password;
  bool isObscure;

  LoginState({
    this.status = LoginStatus.initial,
    this.error,
    this.email = 'string@gmail.com',
    this.password = 'string',
    this.isObscure = true,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    String? email,
    String? password,
    bool? isObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final UserNotifier _userNotifier;

  LoginNotifier(this._userNotifier) : super(LoginState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void toggleObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  Future<void> login() async {
    try {
      state = state.copyWith(
        status: LoginStatus.loading,
        error: null,
      );

      //TODO: riverpod kullanılabilir.
      final response = await UserService().login(
        state.email,
        state.password,
      );
      final user = response['user'];
      final token = response['access_token'];

      await _userNotifier.login(user, token);

      state = state.copyWith(
        status: LoginStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: LoginStatus.error,
        error: e.toString(),
      );
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(ref.watch(userProvider.notifier)),
);
