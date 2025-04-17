import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/services/api_service.dart';

class NewPasswordState {
  final String email;
  final String code;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  NewPasswordState({
    this.email = '',
    this.code = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  NewPasswordState copyWith({
    String? email,
    String? code,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NewPasswordState(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class NewPasswordNotifier extends StateNotifier<NewPasswordState> {
  final ApiService _apiService;

  NewPasswordNotifier(this._apiService) : super(NewPasswordState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateCode(String code) {
    state = state.copyWith(code: code);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> resetPassword() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _apiService.resetPassword(
        email: state.email,
        code: state.code,
        newPassword: state.password,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      throw e;
    }
  }
}

final newPasswordProvider =
    StateNotifierProvider<NewPasswordNotifier, NewPasswordState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return NewPasswordNotifier(apiService);
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
