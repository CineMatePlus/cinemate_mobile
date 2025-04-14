import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(ApiServiceRef ref) {
  return ApiService();
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref);
}
