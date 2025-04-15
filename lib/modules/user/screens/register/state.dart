import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../service/service.dart';

class RegisterState {
  final String email;
  final String password;
  final String name;
  final bool isLoading;
  final String? errorMessage;
  final bool isObscure;

  RegisterState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.isLoading = false,
    this.errorMessage,
    this.isObscure = true,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? name,
    bool? isLoading,
    String? errorMessage,
    bool? isObscure,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void toggleObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  Future<User> register() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await UserService().register(
        state.email,
        state.password,
        state.name,
      );
      state = state.copyWith(isLoading: false);
      return user;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
      rethrow;
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) => RegisterNotifier(),
);
