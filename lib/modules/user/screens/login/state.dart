import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../service/service.dart';

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final bool isObscure;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.isObscure = true,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    bool? isObscure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void toggleObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  Future<User> login() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await UserService().login(state.email, state.password);
      state = state.copyWith(isLoading: false);
      return user;
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
      rethrow;
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
