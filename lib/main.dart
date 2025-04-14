import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'modules/auth/widgets/auth_wrapper.dart';
import 'core/constants/theme_constants.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CinemateApp(),
    ),
  );
}

class CinemateApp extends StatelessWidget {
  const CinemateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinemate',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: ThemeConstants.primaryColor,
          secondary: ThemeConstants.secondaryColor,
          surface: ThemeConstants.backgroundColor,
        ),
        scaffoldBackgroundColor: ThemeConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeConstants.primaryColor,
          elevation: 0,
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}
