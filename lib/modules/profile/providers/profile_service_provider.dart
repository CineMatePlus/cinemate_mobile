import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/profile_service.dart';
import '../../../core/providers/api_service_provider.dart';

part 'profile_service_provider.g.dart';

@riverpod
ProfileService profileService(ProfileServiceRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProfileService(apiService);
}
