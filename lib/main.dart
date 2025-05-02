import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'modules/onboarding/splash/splash.view.dart';
import 'core/constants/theme_constants.dart';
import 'core/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema modu provider'ını izle
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'CineMate',
      themeMode: themeMode, // Sistem ayarı veya kullanıcı seçimi
      theme: ThemeConstants.lightTheme, // Light tema
      darkTheme: ThemeConstants.darkTheme, // Dark tema
      home: const SplashScreen(),
    );
  }
}
