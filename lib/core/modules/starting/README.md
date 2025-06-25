# Starting Modülü

Bu modül, uygulama başlangıç akışını yönetmek için kullanılır. Splash, Onboarding ve Ana ekrana yönlendirme işlemlerini içerir.

## Özellikler

- **Akış Yönetimi**: Uygulama açılışında gerekli ekranlara yönlendirme
- **Onboarding Kontrolü**: Kullanıcı daha önce onboarding tamamladı mı kontrolü
- **Onboarding Ekranları**: Uygulama tanıtım sayfaları
- **Auth Kontrolü**: Kimlik doğrulama gerekli mi ve kullanıcı giriş yapmış mı kontrolü

## Akış Şeması

1. Uygulama başlatıldığında akış kontrolü başlar (UI gösterilmez)
2. "isOnboarding" kontrolü yapılır
   - Eğer onboarding tamamlanmadıysa → Onboarding ekranına yönlendirilir
   - Eğer onboarding tamamlandıysa → Auth kontrolüne geçilir
3. Auth kontrolü için "isAuthenticationNeccessery" değişkeni kontrol edilir
   - Eğer isAuthenticationNeccessery=true ise → Authentication kontrolü yapılır
     - Authenticated ise → HomePage'e yönlendirilir
     - Unauthenticated ise → Login sayfasına yönlendirilir
   - Eğer isAuthenticationNeccessery=false ise → Direkt olarak HomePage'e yönlendirilir

## Kullanım

### AppStartingFlow Widget'ı

AppStartingFlow widget'ı, tüm başlangıç akışını otomatik olarak yönetir:

```dart
AppStartingFlow(
  homePage: MyHomePage(), // Ana sayfa widget'ınız
  loginPage: LoginScreen(), // Login sayfası widget'ınız
  splashConfig: SplashConfig(isAuthenticationNeccessery: true), // İsteğe bağlı
)
```

### SplashScreen

SplashScreen artık UI göstermeyen, sadece yönlendirme mantığını yöneten bir yapıya sahiptir:

```dart
SplashScreen(
  onNavigateToOnboarding: () {
    // Onboarding ekranına git
  },
  onNavigateToHome: () {
    // Ana sayfaya git
  },
  onNavigateToLogin: () {
    // Giriş sayfasına git
  },
)
```

### Onboarding Ekranı

```dart
OnboardingScreen(
  onComplete: () {
    // Onboarding tamamlandığında yapılacak işlemler
  },
  // İsteğe bağlı olarak özel sayfalar tanımlanabilir
  pages: [
    OnboardingPage(
      title: 'Başlık',
      description: 'Açıklama',
      icon: Icons.star,
      backgroundColor: Colors.blue,
    ),
    // Diğer sayfalar...
  ],
)
```

### Splash Konfigürasyonu

Splash yapılandırmasında artık sadece authentication kontrolü için bir değişken bulunmaktadır:

```dart
SplashConfig(
  isAuthenticationNeccessery: true, // veya false
)
```

## Modül Yapısı

```
starting/
├── flow/
│   ├── starting_flow.dart
│   └── state.dart
├── splash/
│   ├── screens/
│   │   └── view.dart
│   └── config.dart
├── oboarding/
│   ├── screens/
│   │   └── view.dart
│   ├── models/
│   │   └── onboarding_item.dart
│   └── state.dart
├── utils/
│   └── preferences_service.dart
└── index.dart
``` 

## Önemli Notlar

- **UI Gösterimi**: SplashScreen artık kullanıcıya herhangi bir UI göstermez. Uygulama açılışındaki logo ekranı, Flutter'ın native splash screen mekanizması veya başka bir yapı üzerinden yönetilmelidir.
- **Yapay Gecikmeler**: Modül, yapay bekleme sürelerini kullanmaz ve mümkün olan en hızlı şekilde uygun ekrana yönlendirme yapar.
- **Durum Yönetimi**: Durum yönetimi için Riverpod kullanılmaktadır.
- **Örnek Kullanım**: Bir örnek için main.dart dosyasına bakabilirsiniz. 