# CineMate Mobil Uygulaması Teknik Raporu

## 1. Proje Özeti

CineMate, film ve dizi takip etmek için geliştirilmiş kapsamlı bir mobil uygulamadır. Kullanıcılar, içerikleri keşfedebilir, izleme listeleri oluşturabilir, içerikleri beğenebilir ve izleme durumlarını takip edebilirler. Uygulama, modern ve kullanıcı dostu bir arayüz ile Flutter framework'ü kullanılarak geliştirilmiştir.

## 2. Mimari ve Yapı

### Ana Mimari

Uygulama, Flutter ve Riverpod state management framework'ü kullanılarak modüler bir yapıda geliştirilmiştir. Uygulama mimarisi şu şekilde tasarlanmıştır:

- **Core**: Temel bileşenler, servisler, model sınıfları ve yardımcı araçlar
- **Modules**: Farklı uygulama özellikleri için modüller (onboarding, home, user, profile, detail vb.)

### Klasör Yapısı

```
/lib
  /core
    /constants
    /models
    /providers
    /services
    /utils
    /widgets
  /modules
    /common
    /detail
    /home
    /onboarding
    /profile
    /user
  main.dart
```

## 3. Kullanılan Teknolojiler ve Kütüphaneler

### Temel Teknolojiler

- **Flutter**: Çapraz platform geliştirme için ana framework
- **Dart**: Programlama dili

### Önemli Bağımlılıklar

```yaml
dependencies:
  flutter: sdk: flutter
  dio: ^5.4.0                     # HTTP istekleri için
  flutter_secure_storage: ^9.0.0  # Güvenli veri depolama (token vb.)
  flutter_riverpod: ^2.4.9        # State yönetimi
  riverpod_annotation: ^2.3.0     # Riverpod için ek özellikler
  freezed_annotation: ^2.4.1      # Immutable sınıflar için
  json_annotation: ^4.8.1         # JSON serialization
  shared_preferences: ^2.5.3      # Yerel veri saklama

dev_dependencies:
  build_runner: ^2.4.0            # Kod üretimi
  riverpod_generator: ^2.3.0      # Riverpod için kod üretici
  freezed: ^2.4.5                 # Immutable sınıflar için kod üretimi
  json_serializable: ^6.7.1       # JSON için kod üretimi
```

## 4. Öne Çıkan Özellikler

### 4.1. Güvenli Kimlik Doğrulama Sistemi

- JWT tabanlı kimlik doğrulama
- Güvenli şifre saklama
- Oturum yönetimi (Login, Register, Logout)
- Şifre sıfırlama akışı (Forgot Password, Verify Code, Reset Password)

```dart
// Şifre Sıfırlama Kodu Doğrulama
Future<bool> verifyResetCode(String email, String code) async {
  try {
    final response = await _apiService.request(
      'POST',
      '/auth/verify-reset-code',
      data: {
        'email': email,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      return response.data['isValid'] as bool;
    } else {
      throw Exception('Kod doğrulama başarısız');
    }
  } catch (e) {
    throw Exception('Kod doğrulama sırasında bir hata oluştu: $e');
  }
}
```

### 4.2. API İletişimi ve Güvenliği

- Dio kütüphanesi kullanılarak merkezi API servisi
- Token tabanlı kimlik doğrulama interceptor'ları
- Otomatik token yenileme
- Hata yönetimi ve kullanıcı dostu hata mesajları

```dart
// API İstek Interceptor'ları
_dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await _storage.read(key: 'token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      options.path = _buildPath(options.path);
      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        await _storage.delete(key: 'token');
      }
      return handler.next(error);
    },
  ),
);
```

### 4.3. Kullanıcı İçerik Etkileşimi

- İçerikleri beğenme/beğenmekten çıkarma
- İzleme listesine ekleme/çıkarma
- İzleme durumu takibi
- Kullanıcı koleksiyonları

```dart
// Kullanıcı İçerik Etkileşimleri
Future<UserContent> toggleLike(String contentId) async {
  final response = await _apiService.request(
    'POST',
    '/user-contents/$contentId/like',
  );
  return UserContent.fromJson(response.data);
}

Future<UserContent> toggleWatch(String contentId) async {
  final response = await _apiService.request(
    'POST',
    '/user-contents/$contentId/watch',
  );
  return UserContent.fromJson(response.data);
}

Future<UserContent> toggleWatchlist(String contentId) async {
  final response = await _apiService.request(
    'POST',
    '/user-contents/$contentId/watchlist',
  );
  return UserContent.fromJson(response.data);
}
```

### 4.4. Karanlık/Aydınlık Tema Desteği

- Sistem ayarlarına göre otomatik tema değiştirme
- Kullanıcı tarafından manuel tema seçimi
- Tema ayarlarının yerel olarak saklanması

```dart
// main.dart'tan tema kullanımı
return MaterialApp(
  title: 'CineMate',
  themeMode: themeMode, // Sistem ayarı veya kullanıcı seçimi
  theme: ThemeConstants.lightTheme, // Light tema
  darkTheme: ThemeConstants.darkTheme, // Dark tema
  home: const SplashScreen(),
);
```

### 4.5. Performans Optimizasyonları

- Freezed ile immutable model sınıfları
- Verimli durum yönetimi için Riverpod
- Veri önbelleğe alma ve optimizasyon

```dart
// Freezed ile Model Tanımlaması
@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: '_id') required String id,
    required String email,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required int gender,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

## 5. Güvenlik Özellikleri

### 5.1. Güvenli Veri Saklama

- `flutter_secure_storage` kullanılarak hassas verilerin (token vb.) güvenli bir şekilde saklanması
- Platforma özgü güvenlik önlemleri (iOS: Keychain, Android: EncryptedSharedPreferences)

### 5.2. Ağ Güvenliği

- HTTPS kullanımı
- JWT token doğrulama
- Request/Response şifreleme (API üzerinden)

### 5.3. Kullanıcı Doğrulama

- Güvenli giriş/kayıt işlemleri
- Şifre sıfırlama için doğrulama kodu sistemi
- Email doğrulama

## 6. Proje Geliştirme Yaklaşımı

### 6.1. Modüler Yapı

Proje modüler bir yaklaşımla geliştirilmiş olup, her bir özellik ayrı bir modül olarak tasarlanmıştır:

- **Onboarding Modülü**: Karşılama ekranları ve kullanıcı girişi
- **Home Modülü**: Ana sayfa, içerik listeleme ve keşif
- **Detail Modülü**: İçerik detay sayfaları
- **User Modülü**: Kullanıcı yönetimi ve kimlik doğrulama
- **Profile Modülü**: Kullanıcı profili ve ayarlar

### 6.2. State Yönetimi

Uygulama genelinde Riverpod kullanılmış olup, durum yönetimi için aşağıdaki yaklaşımlar benimsenmiştir:

- Provider tanımları için riverpod_annotation
- Durum değişiklikleri için StateNotifier
- Etkileşimli durum yönetimi için ConsumerWidget ve ConsumerStatefulWidget

## 7. Geliştirme Potansiyeli ve Öneriler

### 7.1. Gelecek Özellikleri

- **Çevrimdışı Modu**: Offline kullanım için verilerin yerel olarak önbelleğe alınması
- **Sosyal Özellikler**: Arkadaş ekleme, paylaşım ve etkileşim özellikleri
- **Gelişmiş Arama ve Filtreleme**: Daha kapsamlı ve özelleştirilebilir arama özellikleri
- **İçerik Önerileri**: Kişiselleştirilmiş içerik önerileri için makine öğrenimi kullanımı
- **Push Bildirimleri**: Yeni içerikler ve etkileşimler için anlık bildirimler

### 7.2. Teknik İyileştirmeler

- **Test Kapsamı**: Birim testleri ve widget testleri eklenmesi
- **Yerelleştirme**: Çoklu dil desteği
- **Erişilebilirlik**: Erişilebilirlik özelliklerinin geliştirilmesi
- **Performans İyileştirmeleri**: Widget rebuild optimizasyonu ve bellek yönetimi

## 8. API Entegrasyonu

Uygulama, özel bir backend API'si ile iletişim kurmaktadır. API endpointleri:

- **/auth**: Kimlik doğrulama işlemleri (login, register, forgot-password vb.)
- **/user-contents**: Kullanıcı içerik etkileşimleri (like, watch, watchlist)
- **/collections**: Kullanıcı koleksiyonları
- **/contents**: İçerik bilgileri ve arama

API iletişimi, merkezi bir `ApiService` sınıfı üzerinden yönetilmektedir.

## 9. Sonuç

CineMate mobil uygulaması, modern bir film ve dizi takip platformu olarak kullanıcı dostu arayüzü, zengin özellikleri ve güvenli yapısı ile öne çıkmaktadır. Flutter ve Riverpod gibi modern teknolojiler kullanılarak geliştirilen uygulama, genişletilebilir ve sürdürülebilir bir mimari üzerine inşa edilmiştir.

Modüler yapısı, tema desteği, güvenli kimlik doğrulama sistemi ve zengin içerik etkileşim özellikleri ile CineMate, film ve dizi tutkunları için ideal bir takip platformudur.

---

*Bu rapor, CineMate mobil uygulamasının teknik özelliklerini ve yapısını özetlemektedir. Gelecekteki geliştirmeler ve iyileştirmeler için yukarıdaki öneriler dikkate alınabilir.* 