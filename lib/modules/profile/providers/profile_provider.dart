import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../states/profile_state.dart';
import '../services/profile_service.dart';
import 'profile_service_provider.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {
  late final ProfileService _profileService;

  @override
  ProfileState build() {
    _profileService = ref.watch(profileServiceProvider);
    return const ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _profileService.getUserProfile();
      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateProfile({
    required String username,
    required String email,
    required String avatarUrl,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileService.updateProfile(
        username: username,
        email: email,
        avatarUrl: avatarUrl,
      );
      await loadProfile();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addToFavorites(String movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileService.addToFavorites(movieId);
      await loadProfile();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> removeFromFavorites(String movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileService.removeFromFavorites(movieId);
      await loadProfile();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addToWatchlist(String movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileService.addToWatchlist(movieId);
      await loadProfile();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> removeFromWatchlist(String movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileService.removeFromWatchlist(movieId);
      await loadProfile();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markAsWatched(String movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileService.markAsWatched(movieId);
      await loadProfile();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
