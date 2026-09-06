import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionTokens {
  const SessionTokens(this.accessToken, this.refreshToken);
  final String accessToken;
  final String refreshToken;

  factory SessionTokens.fromJson(Map<String, dynamic> json) => SessionTokens(
    json['access_token'] as String,
    json['refresh_token'] as String,
  );
  Map<String, String> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}

abstract class SessionStore {
  Future<SessionTokens?> read();
  Future<void> write(SessionTokens tokens);
  Future<void> clear();
}

class SecureSessionStore implements SessionStore {
  const SecureSessionStore();
  static const _storage = FlutterSecureStorage();
  static const _key = 'session_v2';

  @override
  Future<SessionTokens?> read() async {
    final value = await _storage.read(key: _key);
    // An old access-only session cannot be refreshed safely.
    if (value == null) {
      await _storage.delete(key: 'token');
      return null;
    }
    try {
      return SessionTokens.fromJson(jsonDecode(value) as Map<String, dynamic>);
    } on FormatException {
      await clear();
      return null;
    } on TypeError {
      await clear();
      return null;
    }
  }

  @override
  Future<void> write(SessionTokens tokens) =>
      _storage.write(key: _key, value: jsonEncode(tokens.toJson()));

  @override
  Future<void> clear() async {
    await _storage.delete(key: _key);
    await _storage.delete(key: 'token');
  }
}
