import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/api_service_provider.dart';
import '../../../services/api_service.dart';
import '../models/user.dart';

class AuthService {
  AuthService({required this._apiService});
  final ApiService _apiService;

  set onSessionExpired(void Function()? callback) =>
      _apiService.onSessionExpired = callback;

  Future<User> login(String email, String password) async {
    final response = await _apiService.request(
      'POST',
      '/auth/login',
      data: {'email': email.trim(), 'password': password},
    );
    await _apiService.saveSession(response.data);
    return User.fromJson(response.data['user']);
  }

  Future<User> register(
    String email,
    String name,
    String password,
    int gender,
  ) async {
    final response = await _apiService.request(
      'POST',
      '/auth/register',
      data: {
        'email': email.trim(),
        'name': name.trim(),
        'password': password,
        'gender': gender,
      },
    );
    await _apiService.saveSession(response.data);
    return User.fromJson(response.data['user']);
  }

  Future<User?> refreshTokenAndGetUser() async {
    if (await _apiService.store.read() == null) return null;
    try {
      final response = await _apiService.request('GET', '/auth/me');
      return User.fromJson(response.data);
    } on ApiException catch (error) {
      if (error.statusCode == 401) return null;
      rethrow; // A network outage must not erase a valid refresh session.
    }
  }

  Future<void> logout() async {
    final session = await _apiService.store.read();
    try {
      if (session != null) {
        await _apiService.request(
          'POST',
          '/auth/logout',
          data: {'refresh_token': session.refreshToken},
        );
      }
    } finally {
      await _apiService.clearSession();
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(apiService: ref.watch(apiServiceProvider));
});
