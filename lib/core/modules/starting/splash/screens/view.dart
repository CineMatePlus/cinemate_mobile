import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/state.dart';
import '../../../../routes/route_name.dart';
import '../config.dart';
import '../../utils/preferences_service.dart';

/// Splash ekranı
///
/// Bu widget herhangi bir UI göstermez, sadece routing mantığını yönetir.
/// Uygulama başlatıldığında onboarding, auth veya home ekranlarına yönlendirmeyi sağlar.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  int _authCheckRetryCount = 0;
  static const int _maxAuthCheckRetries = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _handleAppStartingFlow();
    });
  }

  /// Uygulama başlangıç akışını yönet
  Future<void> _handleAppStartingFlow() async {
    if (!mounted) return;

    try {
      final preferencesService = ref.read(preferencesServiceProvider);
      await preferencesService.init();

      final isOnboardingCompleted =
          await preferencesService.isOnboardingCompleted();
      if (!isOnboardingCompleted) {
        if (mounted) context.go(onboardingPath);
        return;
      }

      final config = ref.read(splashConfigProvider);
      if (!config.isAuthenticationNeccessery) {
        if (mounted) context.go(homePath);
        return;
      }

      final authState = ref.read(authProvider);
      switch (authState.status) {
        case AuthStatus.authenticated:
          if (mounted) context.go(homePath);
          break;
        case AuthStatus.unauthenticated:
        case AuthStatus.error:
        case AuthStatus.initial:
          if (mounted) context.go(loginPath);
          break;
        case AuthStatus.loading:
          if (_authCheckRetryCount < _maxAuthCheckRetries) {
            _authCheckRetryCount++;
            await Future.delayed(const Duration(milliseconds: 500));
            await _handleAppStartingFlow();
          } else {
            if (mounted) context.go(loginPath);
          }
          break;
      }
    } catch (e) {
      if (mounted) context.go(loginPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox.shrink(),
      ),
    );
  }
}
