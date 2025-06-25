import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/home/view.dart';
import '../../modules/profile/screens/view.dart';
import '../modules/auth/screens/login/view.dart';
import '../modules/auth/screens/register/view.dart';
import '../modules/auth/state.dart';
import '../modules/starting/onboarding/screens/view.dart';
import '../modules/starting/splash/screens/view.dart';
import 'route_name.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: splashPath,
    //TODO: debugLogDiagnostics true yapılarak kontrol edilecek
    debugLogDiagnostics: false,
    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isAuthenticating = authState.status == AuthStatus.loading;
      final hasError = authState.status == AuthStatus.error;
      final isUnauthenticated = authState.status == AuthStatus.unauthenticated;

      final currentLocation = state.uri.path;

      // İlk yüklenme sırasında loading durumunda splash'e git
      // Ama form işlemleri sırasında (login/register) loading'de kalmaya izin ver
      if (isAuthenticating &&
          currentLocation != splashPath &&
          currentLocation != loginPath &&
          currentLocation != registerPath) {
        return splashPath;
      }

      final publicRoutes = [
        splashPath,
        loginPath,
        registerPath,
        onboardingPath,
      ];
      final isPublicRoute = publicRoutes.contains(currentLocation);

      if (isAuthenticated) {
        // Authenticated ise login/register'dan home'a git
        if (currentLocation == loginPath || currentLocation == registerPath) {
          return homePath;
        }
      } else if (isUnauthenticated || hasError) {
        // Unauthenticated veya error durumunda sadece protected sayfalardan çık
        // Public sayfalar (login, register) kalabilir
        if (!isPublicRoute) {
          return loginPath;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: splashPath,
        name: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: loginPath,
        name: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: registerPath,
        name: registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: onboardingPath,
        name: onboardingRoute,
        builder: (context, state) => OnboardingView(
          onComplete: () {
            context.go(homePath);
          },
        ),
      ),
      GoRoute(
        path: homePath,
        name: homeRoute,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: profilePath,
        name: profileRoute,
        builder: (context, state) => const ProfileView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Hata')),
      body: Center(
        child: Text(
            'Sayfa bulunamadı: ${state.error?.toString() ?? 'Bilinmeyen hata'}'),
      ),
    ),
  );
});
