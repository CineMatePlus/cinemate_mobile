import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/service.dart';

class ForgotPasswordState {
  final String email;
  final bool isLoading;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier() : super(const ForgotPasswordState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  Future<void> sendResetEmail() async {
    state = state.copyWith(isLoading: true);
    try {
      await UserService().forgotPassword(state.email);
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

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
  return ForgotPasswordNotifier();
});
