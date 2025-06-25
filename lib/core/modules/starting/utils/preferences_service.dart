import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Uygulama tercihlerini yönetmek için servis
class PreferencesService {
  late SharedPreferences _prefs;

  /// Servis başlatma
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    log('[PreferencesService] SharedPreferences initialized');
  }

  /// Onboarding tamamlandı mı?
  Future<bool> isOnboardingCompleted() async {
    final completed = _prefs.getBool('isOnboardingCompleted') ?? false;
    log('[PreferencesService] isOnboardingCompleted: $completed');
    return completed;
  }

  /// Onboarding tamamlandı olarak işaretle
  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool('isOnboardingCompleted', true);
    log('[PreferencesService] setOnboardingCompleted: true');
  }

  /// Onboarding durumunu sıfırla (test için)
  Future<void> resetOnboardingStatus() async {
    await _prefs.setBool('isOnboardingCompleted', false);
    log('[PreferencesService] resetOnboardingStatus: false');
  }
}

/// Preferences Servis Provider
final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});
