import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../modules/user/service/service.dart';

class CheckDigitState {
  final String email;
  final String code;
  final bool isLoading;
  final String? errorMessage;

  const CheckDigitState({
    this.email = '',
    this.code = '',
    this.isLoading = false,
    this.errorMessage,
  });

  CheckDigitState copyWith({
    String? email,
    String? code,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CheckDigitState(
      email: email ?? this.email,
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final checkDigitProvider =
    StateNotifierProvider<CheckDigitNotifier, CheckDigitState>((ref) {
  return CheckDigitNotifier();
});

class CheckDigitNotifier extends StateNotifier<CheckDigitState> {
  final UserService _userService = UserService();

  CheckDigitNotifier() : super(const CheckDigitState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateCode(String code) {
    state = state.copyWith(code: code);
  }

  Future<bool> verifyCode() async {
    state = state.copyWith(isLoading: true);
    try {
      final isValid =
          await _userService.verifyResetCode(state.email, state.code);
      state = state.copyWith(isLoading: false);
      return isValid;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
      rethrow;
    }
  }
}
