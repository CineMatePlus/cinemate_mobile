import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'modules/user/screens/login/view.dart';
import 'modules/user/screens/register/view.dart';
import 'modules/user/screens/forgot_password/view.dart';
import 'modules/user/screens/forgot_password/check_digit/view.dart';
import 'modules/user/screens/forgot_password/new_pass/view.dart';
import 'modules/user/screens/forgot_password/success_pass/view.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/forgot-password': (context) => const ForgotPasswordView(),
        '/check-digit': (context) => const CheckDigitView(),
        '/new-password': (context) => const NewPasswordView(),
        '/success-password': (context) => const SuccessPasswordView(),
      },
    );
  }
}
