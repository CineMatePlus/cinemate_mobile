import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/view.dart';
import '../../auth/screens/login/view.dart';
import '../../auth/state.dart';
import '../state.dart';
import '../view.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final onboardingNotifier = ref.read(onboardingStateProvider.notifier);
      await onboardingNotifier.initializeOnboardingState();

      final onboardingState = ref.read(onboardingStateProvider);
      if (onboardingState.isOnboardingCompleted == false) {
        // Onboarding tamamlanmamışsa OnboardingScreen'e yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      } else {
        // Onboarding tamamlanmışsa ana sayfaya yönlendir
        final authNotifier = ref.read(userProvider.notifier);
        await authNotifier.checkAuth();

        final authState = ref.read(userProvider);
        if (authState.status == UserStatus.authenticated) {
          log('Logged in');
          log(authState.user.toString());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          log(authState.user.toString());
          log(authState.status.toString());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        //TODO: Splash screen için bir görsel ekle (logo)
        child: CircularProgressIndicator(),
      ),
    );
  }
}
