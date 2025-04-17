import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

/// ThemeConstants sınıfı, istemci kodları tarafından direkt kullanılabilecek
/// tema değerlerini sunar. Tema modu durumuna göre (dark/light) otomatik
/// olarak doğru değeri döndürür.
class ThemeConstants {
  // Genel ölçüler (tema modundan bağımsız sabitler)
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;

  // Marka renkleri (tema modundan bağımsız sabitler)
  static const Color accentColor = Color(0xFFE50914);
  static const Color errorColor = Color(0xFFCF6679);
  static const Color successColor = Color(0xFF4CAF50);

  // Dark tema renkleri
  static const Color _darkPrimaryColor = Color.fromARGB(255, 119, 152, 245);
  static const Color _darkSecondaryColor = Color.fromARGB(255, 160, 154, 154);
  static const Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color _darkTextColor = Colors.white;
  static const Color _darkSubtitleColor = Color(0xFFB3B3B3);

  // Light tema renkleri
  static const Color _lightPrimaryColor = Color.fromARGB(255, 66, 106, 215);
  static const Color _lightSecondaryColor = Color(0xFF757575);
  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightSurfaceColor = Color(0xFFF5F5F5);
  static const Color _lightTextColor = Color(0xFF121212);
  static const Color _lightSubtitleColor = Color(0xFF616161);

  // Provider'ı kullanabilmek için bir WidgetRef gerekiyor
  // Bu metot ile mevcut tema moduna göre doğru rengi alabilirsiniz
  static Color _getThemeColor(
      WidgetRef ref, Color darkColor, Color lightColor) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    return isDarkMode ? darkColor : lightColor;
  }

  // Bu metotlar, doğrudan widget'lar içinde kullanılabilir:
  static Color getPrimaryColor(WidgetRef ref) {
    return _getThemeColor(ref, _darkPrimaryColor, _lightPrimaryColor);
  }

  static Color getSecondaryColor(WidgetRef ref) {
    return _getThemeColor(ref, _darkSecondaryColor, _lightSecondaryColor);
  }

  static Color getBackgroundColor(WidgetRef ref) {
    return _getThemeColor(ref, _darkBackgroundColor, _lightBackgroundColor);
  }

  static Color getSurfaceColor(WidgetRef ref) {
    return _getThemeColor(ref, _darkSurfaceColor, _lightSurfaceColor);
  }

  static Color getTextColor(WidgetRef ref) {
    return _getThemeColor(ref, _darkTextColor, _lightTextColor);
  }

  static Color getSubtitleColor(WidgetRef ref) {
    return _getThemeColor(ref, _darkSubtitleColor, _lightSubtitleColor);
  }

  // Geriye dönük uyumluluk için sabit renkler (dark tema değerleri)
  static const Color primaryColor = _darkPrimaryColor;
  static const Color secondaryColor = _darkSecondaryColor;
  static const Color backgroundColor = _darkBackgroundColor;
  static const Color textColor = _darkTextColor;
  static const Color subtitleColor = _darkSubtitleColor;

  // Geriye dönük uyumluluk için sabit renk referansları
  static const Color darkPrimaryColor = _darkPrimaryColor;
  static const Color darkSecondaryColor = _darkSecondaryColor;
  static const Color darkBackgroundColor = _darkBackgroundColor;
  static const Color darkSurfaceColor = _darkSurfaceColor;
  static const Color darkTextColor = _darkTextColor;
  static const Color darkSubtitleColor = _darkSubtitleColor;

  static const Color lightPrimaryColor = _lightPrimaryColor;
  static const Color lightSecondaryColor = _lightSecondaryColor;
  static const Color lightBackgroundColor = _lightBackgroundColor;
  static const Color lightSurfaceColor = _lightSurfaceColor;
  static const Color lightTextColor = _lightTextColor;
  static const Color lightSubtitleColor = _lightSubtitleColor;

  // Dark ve light temalar için gerçek ThemeData nesneleri (Material 3)
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      surface: _lightSurfaceColor,
      background: _lightBackgroundColor,
      error: accentColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: _lightTextColor),
      bodyMedium: TextStyle(color: _lightTextColor),
      titleLarge: TextStyle(color: _lightTextColor),
    ),
    cardTheme: CardTheme(
      color: _lightSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
    ),
  );

  // Dark tema
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    scaffoldBackgroundColor: _darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      surface: _darkSurfaceColor,
      background: _darkBackgroundColor,
      error: accentColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurfaceColor,
      foregroundColor: _darkTextColor,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: _darkTextColor),
      bodyMedium: TextStyle(color: _darkTextColor),
      titleLarge: TextStyle(color: _darkTextColor),
    ),
    cardTheme: CardTheme(
      color: _darkSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
    ),
  );
}
