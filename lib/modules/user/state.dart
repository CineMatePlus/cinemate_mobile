import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user.dart';

class UserState {
  String? accessToken;
  User? user;
  bool? isLoggedIn;

  UserState({this.accessToken, this.user, this.isLoggedIn});

  UserState copyWith({String? accessToken, User? user, bool? isLoggedIn}) {
    return UserState(
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }

  UserState copyWithAccessToken(String accessToken) {
    return copyWith(accessToken: accessToken);
  }

  UserState copyWithUser(User user) {
    return copyWith(user: user, isLoggedIn: true);
  }

  UserState copyWithIsLoggedIn(bool isLoggedIn) {
    return copyWith(isLoggedIn: isLoggedIn);
  }
}

class UserStateNotifier extends StateNotifier<UserState> {
  UserStateNotifier() : super(UserState());

  void setAccessToken(String accessToken) {
    state = state.copyWithAccessToken(accessToken);
  }

  void setUser(User user) {
    state = state.copyWithUser(user);
  }

  void setIsLoggedIn(bool isLoggedIn) {
    state = state.copyWithIsLoggedIn(isLoggedIn);
  }

  void login(String accessToken, User user) {
    setAccessToken(accessToken);
    setUser(user);
    setIsLoggedIn(true);
  }

  void logout() {
    state = UserState(accessToken: null, user: null, isLoggedIn: false);
  }
}

final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(),
);
