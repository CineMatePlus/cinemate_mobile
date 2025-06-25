import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Splash ekranı yapılandırması
class SplashConfig {
  /// Kimlik doğrulama kontrolü gerekli mi
  final bool isAuthenticationNeccessery;

  /// Varsayılan yapılandırma
  const SplashConfig({this.isAuthenticationNeccessery = true});

  /// Yapılandırmayı değiştir
  SplashConfig copyWith({bool? isAuthenticationNeccessery}) {
    return SplashConfig(
      isAuthenticationNeccessery:
          isAuthenticationNeccessery ?? this.isAuthenticationNeccessery,
    );
  }
}

/// Varsayılan splash yapılandırması provider'ı
final splashConfigProvider = Provider<SplashConfig>((ref) {
  return const SplashConfig();
});
