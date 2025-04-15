import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../modules/user/service/service.dart';

class NewPasswordState {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;
  final bool isObscure;
  final bool isLoading;
  final String? errorMessage;

  const NewPasswordState({
    this.email = '',
    this.code = '',
    this.password = '',
    this.confirmPassword = '',
    this.isObscure = true,
    this.isLoading = false,
    this.errorMessage,
  });

  NewPasswordState copyWith({
    String? email,
    String? code,
    String? password,
    String? confirmPassword,
    bool? isObscure,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NewPasswordState(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isObscure: isObscure ?? this.isObscure,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final newPasswordProvider =
    StateNotifierProvider<NewPasswordNotifier, NewPasswordState>((ref) {
  return NewPasswordNotifier();
});

class NewPasswordNotifier extends StateNotifier<NewPasswordState> {
  final UserService _userService = UserService();

  NewPasswordNotifier() : super(const NewPasswordState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateCode(String code) {
    state = state.copyWith(code: code);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  void toggleObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  Future<void> resetPassword() async {
    if (state.password != state.confirmPassword) {
      throw Exception('Şifreler eşleşmiyor');
    }

    state = state.copyWith(isLoading: true);
    try {
      await _userService.resetPassword(state.email, state.code, state.password);
      state = state.copyWith(isLoading: false);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
      rethrow;
    }
  }
}
