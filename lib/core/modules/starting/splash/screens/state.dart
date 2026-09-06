import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/preferences_service.dart';
import '../../../auth/state.dart';
import '../config.dart';

/// Splash ekranı akış durumu
enum SplashNavigationState {
  /// Başlangıç durumu (henüz kontroller yapılmamış)
  initial,

  /// Onboarding ekranına yönlendirilmeli
  onboarding,

  /// Ana sayfaya yönlendirilmeli
  homePage,

  /// Giriş sayfasına yönlendirilmeli
  loginPage,

  /// Hata oluştu
  error,
}

/// Splash ekranının durumu
class SplashState {
  /// Yükleniyor mu?
  final bool isLoading;

  /// Hata mesajı (varsa)
  final String? errorMessage;

  /// Yönlendirme durumu
  final SplashNavigationState navigationState;

  const SplashState({
    this.isLoading = true,
    this.errorMessage,
    this.navigationState = SplashNavigationState.initial,
  });

  /// Yeni durumla birleştir
  SplashState copyWith({
    bool? isLoading,
    String? errorMessage,
    SplashNavigationState? navigationState,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      navigationState: navigationState ?? this.navigationState,
    );
  }

  /// İlk durum
  static SplashState get initial => const SplashState();

  /// Hata durumu
  static SplashState error(String message) => SplashState(
    isLoading: false,
    errorMessage: message,
    navigationState: SplashNavigationState.error,
  );
}

/// Splash ekranı state notifier
class SplashNotifier extends StateNotifier<SplashState> {
  final PreferencesService _preferencesService;
  final AuthState? _authState;
  final SplashConfig _config;

  SplashNotifier({
    required this._preferencesService,
    required this._config,
    this._authState,
  }) : super(SplashState.initial);

  /// Akış kontrolünü başlat (Splash süresinden sonra çağrılmalı)
  Future<void> checkFlow() async {
    try {
      await _preferencesService.init();

      // 1. Onboarding kontrolü
      final isOnboardingCompleted = await _preferencesService
          .isOnboardingCompleted();

      if (!isOnboardingCompleted) {
        state = state.copyWith(
          isLoading: false,
          navigationState: SplashNavigationState.onboarding,
        );
        return;
      }

      // 2. Auth kontrolü gerekli mi?
      if (!_config.isAuthenticationNeccessery) {
        // Auth gerekli değilse direkt ana sayfaya yönlendir
        state = state.copyWith(
          isLoading: false,
          navigationState: SplashNavigationState.homePage,
        );
        return;
      }

      // 3. Auth durumunu kontrol et
      // Auth durumuna göre yönlendirme
      if (_authState?.status == AuthStatus.authenticated) {
        state = state.copyWith(
          isLoading: false,
          navigationState: SplashNavigationState.homePage,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          navigationState: SplashNavigationState.loginPage,
        );
      }
    } catch (e) {
      state = SplashState.error(e.toString());
    }
  }

  /// State'i sıfırla (yeniden Splash göstermek için)
  void reset() {
    state = SplashState.initial;
  }
}

/// Splash Provider
final splashProvider = StateNotifierProvider<SplashNotifier, SplashState>((
  ref,
) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  final authState = ref.watch(authProvider);
  final config = ref.watch(splashConfigProvider);

  return SplashNotifier(
    preferencesService: preferencesService,
    authState: authState,
    config: config,
  );
});
