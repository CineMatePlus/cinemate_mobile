import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  SharedPreferences? _prefs;
  static const String _prefsKey = 'isLightMode';

  ThemeNotifier() : super(ThemeMode.dark) {
    _initPrefs();
  }

  // SharedPreferences'ı başlat ve tema modunu yükle
  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _loadThemeMode();
    } catch (e) {
      debugPrint('SharedPreferences hatası: $e');
      // Varsayılan olarak dark mode kullan
      state = ThemeMode.dark;
    }
  }

  // Tema modunu yükle
  void _loadThemeMode() {
    try {
      if (_prefs != null) {
        final isLightMode = _prefs!.getBool(_prefsKey) ?? false;
        state = isLightMode ? ThemeMode.light : ThemeMode.dark;
      }
    } catch (e) {
      debugPrint('Tema modu yüklenirken hata: $e');
      // Varsayılan olarak dark mode kullan
      state = ThemeMode.dark;
    }
  }

  // Tema modunu değiştir
  Future<void> toggleTheme() async {
    try {
      final newThemeMode =
          state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

      if (_prefs != null) {
        await _prefs!.setBool(_prefsKey, newThemeMode == ThemeMode.light);
      }

      state = newThemeMode;
    } catch (e) {
      debugPrint('Tema değiştirilirken hata: $e');
      // Yine de UI'da değişikliği göster ama persistant olarak saklanamayabilir
      final newThemeMode =
          state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      state = newThemeMode;
    }
  }

  // Belirli bir tema modunu ayarla
  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      if (_prefs != null) {
        await _prefs!.setBool(_prefsKey, themeMode == ThemeMode.light);
      }
      state = themeMode;
    } catch (e) {
      debugPrint('Tema modu ayarlanırken hata: $e');
      // Yine de UI'da değişikliği göster
      state = themeMode;
    }
  }

  // Şu anki tema koyu mu
  bool get isDarkMode => state == ThemeMode.dark;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
