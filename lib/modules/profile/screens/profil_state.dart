import 'package:cinemate_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/user.dart';
import '../../onboarding/splash.view.dart';
import '../../user/service/service.dart';

class ProfileState {
  final User? user;
  final bool isLoading;
  final String? error;
  final String selectedLanguage;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
    this.selectedLanguage = 'tr',
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    String? selectedLanguage,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState());

  Future<void> loadUserProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      // Fetch user data from API
      final user = await fetchUserProfileFromApi();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Profil yüklenirken bir hata oluştu',
        isLoading: false,
      );
    }
  }

  void updateLanguage(String language) {
    state = state.copyWith(selectedLanguage: language);
  }

  void updateUserProfile(User updatedUser) {
    state = state.copyWith(user: updatedUser);
  }

  Future<void> logout(BuildContext context) async {
    try {
      await SecureStorageUtils.deleteToken(); // Kullanıcıyı localden sil
      state = state.copyWith(user: null, isLoading: false); // State'i sıfırla

      // SplashScreen'e yönlendir
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Çıkış yapılırken bir hata oluştu',
        isLoading: false,
      );
    }
  }

  Future<User> fetchUserProfileFromApi() async {
    try {
      final response = await UserService().me();
      return response;
    } catch (e) {
      throw Exception('Kullanıcı profili alınamadı: $e');
    }
  }
}
