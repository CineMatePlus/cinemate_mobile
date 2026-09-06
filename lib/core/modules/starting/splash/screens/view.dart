import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/state.dart';
import '../../../../routes/route_name.dart';
import '../../utils/preferences_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool? _onboarded;
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.init();
    final done = await prefs.isOnboardingCompleted();
    if (mounted) setState(() => _onboarded = done);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    String? next;
    if (_onboarded == false) {
      next = onboardingPath;
    } else if (_onboarded == true && auth.status == AuthStatus.authenticated) {
      next = homePath;
    } else if (_onboarded == true &&
        auth.status == AuthStatus.unauthenticated) {
      next = loginPath;
    }
    if (next != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(next!);
      });
    }
    return Scaffold(
      body: Center(
        child: auth.status == AuthStatus.error
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(auth.errorMessage ?? 'Bağlantı kurulamadı.'),
                  FilledButton(
                    onPressed: () =>
                        ref.read(authProvider.notifier).checkAuthStatus(),
                    child: const Text('Tekrar dene'),
                  ),
                  TextButton(
                    onPressed: () => context.go(loginPath),
                    child: const Text('Giriş ekranı'),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
