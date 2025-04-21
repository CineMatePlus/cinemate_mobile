import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/service.dart';
import '../../state.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

// Gender değerleri
// 0: Kadın
// 1: Erkek
// 2: Diğer

class RegisterState {
  final RegisterStatus status;
  final String? errorMessage;
  final String email;
  final String password;
  final String name;
  final int? gender;
  final bool isObscure;

  RegisterState({
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.email = '',
    this.password = '',
    this.name = '',
    this.gender,
    this.isObscure = true,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
    String? email,
    String? password,
    String? name,
    int? gender,
    bool? isObscure,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final UserNotifier _userNotifier;

  RegisterNotifier(this._userNotifier) : super(RegisterState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateGender(int gender) {
    state = state.copyWith(gender: gender);
  }

  void toggleObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  Future<void> register() async {
    try {
      state = state.copyWith(
        status: RegisterStatus.loading,
        errorMessage: null,
      );

      final response = await UserService().register(
        state.email,
        state.password,
        state.name,
        gender: state.gender,
      );

      final user = response['user'];
      final token = response['access_token'];

      await _userNotifier.login(user, token);

      state = state.copyWith(
        status: RegisterStatus.success,
      );
    } catch (error) {
      state = state.copyWith(
        status: RegisterStatus.error,
        errorMessage: error.toString(),
      );
      rethrow;
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) => RegisterNotifier(ref.watch(userProvider.notifier)),
);
