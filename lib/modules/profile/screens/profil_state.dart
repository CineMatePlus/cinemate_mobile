import 'package:cinemate_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/models/user.dart';

import '../../onboarding/splash.view.dart';
import '../service/service.dart';

class ProfileState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isDarkMode;
  final bool isNotificationsEnabled;
  final String selectedLanguage;
  final String bio;
  final String website;
  final List<String> interests;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isDarkMode = false,
    this.isNotificationsEnabled = true,
    this.selectedLanguage = 'tr',
    this.bio = '',
    this.website = '',
    this.interests = const [],
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isDarkMode,
    bool? isNotificationsEnabled,
    String? selectedLanguage,
    bool? isPrivateProfile,
    int? confessionCount,
    int? followersCount,
    int? followingCount,
    String? bio,
    String? website,
    List<String>? interests,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      bio: bio ?? this.bio,
      website: website ?? this.website,
      interests: interests ?? this.interests,
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

  void updateTheme(bool isDark) {
    state = state.copyWith(isDarkMode: isDark);
  }

  void updateNotifications(bool enabled) {
    state = state.copyWith(isNotificationsEnabled: enabled);
  }

  void updateLanguage(String language) {
    state = state.copyWith(selectedLanguage: language);
  }

  void updatePrivacySettings(bool isPrivate) {
    state = state.copyWith(isPrivateProfile: isPrivate);
  }

  void updateUserProfile(User updatedUser) {
    state = state.copyWith(user: updatedUser);
  }

  Future<void> logout(BuildContext context) async {
    try {
      await SecureStorageUtils.deleteToken(); // Kullanıcıyı localden sil
      state = state.copyWith(user: null, isLoading: false); // State'i sıfırla

      // SplashScreen'e yönlendir
      //TODO: SplashScreen'e yönlendirecek miyiz yoksa state otomatik olarak değişecek mi?
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
      final response = await ProfileService().me();
      return response;
    } catch (e) {
      throw Exception('Kullanıcı profili alınamadı: $e');
    }
  }
}
