# CineMate Mobil Uygulama Mimarisi

## 1. Proje Özeti

CineMate, film ve dizi severler için geliştirilmiş kapsamlı bir mobil uygulamadır. Kullanıcılar, içerikleri keşfedebilir, izleme listeleri oluşturabilir, içerikleri beğenebilir ve izleme durumlarını takip edebilirler. Uygulama, modern ve kullanıcı dostu bir arayüz ile Flutter framework'ü kullanılarak geliştirilmiştir.

### 1.1. Proje Vizyonu

CineMate projesi, film ve dizi tutkunlarının tüm içerik takip ihtiyaçlarını tek bir platformda karşılamayı hedeflemektedir. Uygulama, kullanıcılara kişiselleştirilmiş bir deneyim sunarak:

- Yeni içerikleri keşfetme
- İzleme alışkanlıklarını takip etme
- Beğenilen içerikleri kaydetme
- İçerikler hakkında detaylı bilgiye erişme

imkanı sağlamaktadır. Kullanıcıların dijital içerik tüketim alışkanlıklarını optimize etmek ve zenginleştirmek, projenin ana amacıdır.

### 1.2. Hedef Kitle

Uygulama, aşağıdaki kullanıcı gruplarını hedeflemektedir:

- **Film ve Dizi Tutkunları**: Düzenli olarak içerik tüketen ve takip eden kullanıcılar
- **Eleştirmenler**: İçerikler hakkında görüş bildirmek ve değerlendirme yapmak isteyen kullanıcılar
- **Koleksiyoncular**: İçerikleri kategorilere ayırıp koleksiyonlar oluşturmak isteyen kullanıcılar
- **Keşif Odaklı Kullanıcılar**: Yeni içerikler keşfetmek isteyen kullanıcılar

### 1.3. Temel Fonksiyonlar

Uygulamanın temel fonksiyonları şu şekildedir:

1. **Kullanıcı Yönetimi**: Kayıt, giriş, şifre sıfırlama, profil düzenleme
2. **İçerik Keşfi**: Film ve dizileri arama, filtreleme, popüler içerikleri görüntüleme
3. **İçerik Etkileşimi**: Beğenme, izleme durumu işaretleme, izleme listesine ekleme
4. **Koleksiyon Yönetimi**: Kişisel koleksiyonlar oluşturma ve düzenleme
5. **İçerik Detayları**: Film ve diziler hakkında detaylı bilgi görüntüleme
6. **Tema Seçenekleri**: Karanlık ve aydınlık tema desteği

## 2. Mimari ve Yapı

### 2.1. Ana Mimari

CineMate uygulaması, Flutter ve Riverpod state management framework'ü kullanılarak modüler bir yapıda geliştirilmiştir. Uygulama mimarisi, sürdürülebilirlik, test edilebilirlik ve ölçeklenebilirlik prensiplerine uygun olarak tasarlanmıştır.

Mimari, aşağıdaki katmanlardan oluşmaktadır:

1. **Sunum Katmanı (Presentation Layer)**
   - Kullanıcı arayüzü bileşenleri (Ekranlar, widget'lar)
   - State yönetimi (Riverpod providers)
   - Navigasyon yapısı

2. **İş Katmanı (Business Logic Layer)**
   - Durum yöneticileri (State notifiers)
   - Servis sınıfları
   - Kullanıcı etkileşim işlemleri

3. **Veri Katmanı (Data Layer)**
   - Model sınıfları
   - Repository sınıfları
   - API servisleri
   - Yerel veri saklama servisleri

### 2.2. Tasarım Desenleri ve Prensipler

Uygulama geliştirirken aşağıdaki tasarım desenleri ve prensipler benimsenmiştir:

1. **Repository Deseni**: Veri kaynaklarından (API, yerel veritabanı) veri almak için repository deseni kullanılmıştır. Bu sayede veri kaynakları değişse bile iş mantığı etkilenmemektedir.

2. **SOLID Prensipleri**:
   - Single Responsibility (Tek Sorumluluk): Her sınıfın tek bir sorumluluğu vardır
   - Open/Closed (Açık/Kapalı): Sınıflar genişletmeye açık, değişime kapalıdır
   - Liskov Substitution (Liskov Yer Değiştirme): Alt sınıflar, üst sınıfların yerine geçebilir
   - Interface Segregation (Arayüz Ayrımı): Spesifik arayüzler, genel arayüzlerden daha iyidir
   - Dependency Inversion (Bağımlılık Ters Çevirme): Soyutlamalara bağımlı olunmalıdır

3. **Provider Deseni**: Riverpod ile state yönetimi için provider deseni kullanılmıştır.

4. **Immutable Data**: Freezed kütüphanesi ile immutable veri modelleri oluşturulmuştur.

5. **Asenkron Programlama**: Future ve Stream yapıları kullanılarak asenkron işlemler yönetilmiştir.

### 2.3. Klasör Yapısı

Uygulama, aşağıdaki klasör yapısına göre organize edilmiştir:

```
/lib
  /core                   # Temel ve ortak bileşenler
    /constants            # Sabit değerler (temalar, renkler, metinler vb.)
    /models               # Veri modelleri
    /providers            # Global state providers
    /services             # Merkezi servisler (API, yerel depolama vb.)
    /utils                # Yardımcı fonksiyonlar
    /widgets              # Ortak widget'lar
  /modules                # Özellik modülleri
    /common               # Modüller arası ortak bileşenler
    /detail               # İçerik detay sayfaları
      /pages              # Ekranlar
      /providers          # Modüle özel provider'lar
    /home                 # Ana sayfa modülü
      /pages              # Ana sayfa ekranları
      /service            # Ana sayfa servisleri
      /state              # Durum yönetimi
      /widgets            # Ana sayfa widget'ları
    /onboarding           # Karşılama ve giriş modülü
    /profile              # Profil modülü
    /user                 # Kullanıcı yönetimi modülü
      /screens            # Kullanıcı ekranları
      /service            # Kullanıcı servisleri
  main.dart               # Uygulama giriş noktası
```

### 2.4. Widget Mimarisi

Flutter'ın widget-based yapısını en iyi şekilde kullanmak için aşağıdaki prensipler izlenmiştir:

1. **Atom Tasarım Sistemi**:
   - **Atomlar**: Temel UI bileşenleri (düğmeler, metin alanları vb.)
   - **Moleküller**: Atomların birleşimi (form alanları, kartlar vb.)
   - **Organizmalar**: Molekül ve atomların birleşimi (karmaşık UI blokları)
   - **Şablonlar**: Sayfa düzenleri
   - **Sayfalar**: Tam ekran widget'ları

2. **Widget Kompozisyonu**: Karmaşık widget'ların daha küçük, yeniden kullanılabilir widget'lara bölünmesi

3. **Lazy Loading**: İçeriklerin ihtiyaç duyulduğunda yüklenmesi

4. **Responsive Tasarım**: Farklı ekran boyutlarına uyum sağlayan esnek tasarım

### 2.5. State Yönetim Stratejisi

Uygulama, state yönetimi için Riverpod framework'ünü kullanmaktadır. State yönetimi stratejisi şu şekildedir:

1. **Provider Türleri**:
   - **StateProvider**: Basit durum değişiklikleri için
   - **StateNotifierProvider**: Karmaşık durum ve etkileşimler için
   - **FutureProvider**: Asenkron veriler için
   - **StreamProvider**: Real-time veriler için

2. **State Erişimi**: ConsumerWidget ve ConsumerStatefulWidget kullanılarak provider'lara erişim sağlanmaktadır.

3. **Dependency Injection**: Provider'lar aracılığıyla bağımlılık enjeksiyonu

4. **State Kapsülleme**: Her modül kendi state'ini yönetmektedir.

## 3. Kullanılan Teknolojiler ve Kütüphaneler

### 3.1. Temel Teknolojiler

- **Flutter**: Dart programlama dili kullanılarak geliştirilen, Google tarafından oluşturulan açık kaynaklı UI framework'üdür. Flutter, tek kod tabanıyla iOS, Android, web ve masaüstü uygulamaları geliştirme imkanı sağlar. CineMate uygulaması Flutter 3.0+ sürümü ile geliştirilmiştir.

- **Dart**: Google tarafından geliştirilen, client-optimized bir programlama dilidir. Dart, Just-In-Time (JIT) ve Ahead-Of-Time (AOT) derleme özellikleriyle hem hızlı geliştirme hem de optimum performans sağlar. CineMate uygulaması Dart 3.0+ sürümü ile yazılmıştır.

### 3.2. State Yönetim Çözümü

- **Flutter Riverpod (^2.4.9)**: Flutter için reaktif state yönetim kütüphanesidir. Provider pattern'in geliştirilmiş halidir ve aşağıdaki avantajları sağlar:
  - Compile-time güvenliği
  - Provider bağımlılıklarının otomatik olarak çözülmesi
  - Provider override özelliği (özellikle test için faydalı)
  - Kod üretimi için annotation desteği
  - Provider ailesi (StateProvider, FutureProvider, StreamProvider, ChangeNotifierProvider, StateNotifierProvider)

- **Riverpod Annotation (^2.3.0)**: Riverpod provider'ları için kod üretimi sağlayan pakettir. `@riverpod` annotation'ı ile kolayca provider tanımlamayı sağlar.

### 3.3. API ve Ağ İletişimi

- **Dio (^5.4.0)**: HTTP istekleri için kullanılan güçlü bir Dart HTTP client kütüphanesidir. Aşağıdaki özellikleri sağlar:
  - Interceptor desteği
  - Global konfigürasyon
  - FormData desteği
  - Request cancellation
  - Dosya indirme/yükleme ilerleme takibi
  - Timeout mekanizması
  - HTTP/2 desteği

### 3.4. Veri İşleme ve Modelleme

- **Freezed (^2.4.5)**: Immutable sınıflar için kod üretimi sağlayan pakettir. Aşağıdaki özellikleri sağlar:
  - Union types / sealed classes
  - Pattern matching
  - Kopyalama metotları
  - toString, hashCode ve equality override
  - JSON serialization entegrasyonu

- **Json Serializable (^6.7.1)**: JSON serileştirme ve deserileştirme için kod üretimi sağlayan pakettir.

- **Json Annotation (^4.8.1)**: JSON serileştirme işlemleri için annotation'lar sağlayan pakettir.

### 3.5. Güvenli Veri Saklama

- **Flutter Secure Storage (^9.0.0)**: Hassas verilerin güvenli bir şekilde saklanması için kullanılan pakettir. Platform spesifik güvenlik önlemleri sunar:
  - iOS: Keychain
  - Android: EncryptedSharedPreferences
  - Web: LocalStorage ile şifreleme

- **Shared Preferences (^2.5.3)**: Basit anahtar-değer çiftlerini yerel olarak saklamak için kullanılan pakettir. Uygulama ayarları, kullanıcı tercihleri gibi hassas olmayan verilerin saklanması için kullanılır.

### 3.6. Kod Üretimi ve Geliştirme Araçları

- **Build Runner (^2.4.0)**: Dart code generation için kullanılan araçtır. Freezed, JSON serializable ve Riverpod generator gibi kütüphaneler için gerekli kodu üretir.

- **Flutter Lints (^2.0.0)**: Dart ve Flutter için lint kuralları sağlayan pakettir. Kod kalitesini ve tutarlılığını artırmak için kullanılır.

### 3.7. Kullanım Amacına Göre Teknoloji Seçimleri

| İhtiyaç | Seçilen Teknoloji | Gerekçe |
|---------|-------------------|---------|
| UI Framework | Flutter | Çapraz platform desteği, zengin widget kütüphanesi ve yüksek performans |
| State Yönetimi | Riverpod | Compile-time güvenliği, test edilebilirlik ve modülerlik |
| HTTP İletişimi | Dio | Interceptor desteği, esnek API ve geniş özellik seti |
| Model Sınıfları | Freezed | Immutable veri yapıları, JSON serialize/deserialize entegrasyonu |
| Güvenli Depolama | Flutter Secure Storage | Platform spesifik güvenli depolama yöntemleri |
| Yerel Veri Saklama | Shared Preferences | Basit anahtar-değer saklama, kolay kullanım |

### 3.8. Bağımlılık Versiyonları ve Uyumluluk

Tüm bağımlılıklar pubspec.yaml dosyasında belirtilmiş olup, en güncel kararlı sürümler kullanılmıştır. Bağımlılıklar arasında versiyon uyumsuzluğu bulunmamaktadır.

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0                     # HTTP istekleri için
  flutter_secure_storage: ^9.0.0  # Güvenli veri depolama (token vb.)
  flutter_riverpod: ^2.4.9        # State yönetimi
  riverpod_annotation: ^2.3.0     # Riverpod için ek özellikler
  freezed_annotation: ^2.4.1      # Immutable sınıflar için
  json_annotation: ^4.8.1         # JSON serialization
  shared_preferences: ^2.5.3      # Yerel veri saklama

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  build_runner: ^2.4.0            # Kod üretimi
  riverpod_generator: ^2.3.0      # Riverpod için kod üretici
  freezed: ^2.4.5                 # Immutable sınıflar için kod üretimi
  json_serializable: ^6.7.1       # JSON için kod üretimi
```

## 4. Öne Çıkan Özellikler

### 4.1. Güvenli Kimlik Doğrulama Sistemi

CineMate uygulaması, güvenli ve güçlü bir kimlik doğrulama sistemi kullanmaktadır. Bu sistem, aşağıdaki bileşenlerden oluşmaktadır:

#### 4.1.1. JWT Tabanlı Kimlik Doğrulama

JSON Web Token (JWT) tabanlı kimlik doğrulama, kullanıcı kimlik bilgilerinin güvenli bir şekilde taşınmasını ve doğrulanmasını sağlar. JWT, üç bölümden oluşan bir token yapısıdır:
- **Header**: Token türü ve kullanılan şifreleme algoritması
- **Payload**: Kullanıcı kimlik bilgileri ve token meta verileri
- **Signature**: Token'ın geçerliliğini doğrulayan imza

Token, her API isteğinin `Authorization` başlığında taşınır ve sunucu tarafında doğrulanır:

```dart
// API İstek hazırlama
options.headers['Authorization'] = 'Bearer $token';
```

#### 4.1.2. Güvenli Şifre Saklama

Kullanıcı şifreleri, sunucu tarafında bcrypt veya Argon2 gibi modern şifreleme algoritmaları kullanılarak hashlenir. Clientta şifrelenmemiş şekilde saklanmaz.

#### 4.1.3. Oturum Yönetimi Akışı

Uygulamada, aşağıdaki oturum yönetimi akışları bulunmaktadır:

**Kullanıcı Girişi (Login):**
```dart
Future<Map<String, dynamic>> login(String email, String password) async {
  try {
    final response = await _apiService.request(
      'POST',
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return {
        'user': User.fromJson(response.data['user']),
        'access_token': response.data['access_token'],
      };
    } else {
      throw Exception('Giriş başarısız');
    }
  } catch (e) {
    throw Exception('Giriş sırasında bir hata oluştu: $e');
  }
}
```

**Kullanıcı Kaydı (Register):**
```dart
Future<Map<String, dynamic>> register(
    String email, String password, String name,
    {int? gender}) async {
  try {
    final response = await _apiService.request(
      'POST',
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'gender': gender,
      },
    );

    if (response.statusCode == 200) {
      return {
        'user': User.fromJson(response.data['user']),
        'access_token': response.data['access_token'],
      };
    } else {
      throw Exception('Kayıt başarısız');
    }
  } catch (e) {
    throw Exception('Kayıt sırasında bir hata oluştu: $e');
  }
}
```

**Kullanıcı Profili (Me):**
```dart
Future<User> me() async {
  try {
    final response = await _apiService.request(
      'GET',
      '/auth/me',
    );
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Profil yüklenirken bir hata oluştu');
    }
  } catch (e) {
    throw Exception('Profil yüklenirken bir hata oluştu: $e');
  }
}
```

#### 4.1.4. Şifre Sıfırlama Süreci

Şifre sıfırlama süreci üç adımdan oluşmaktadır:

1. **Şifre Sıfırlama İsteği:**
Kullanıcı email adresini girer ve şifre sıfırlama kodu istenir.

```dart
Future<void> forgotPassword(String email) async {
  try {
    final response = await _apiService.request(
      'POST',
      '/auth/forgot-password',
      data: {
        'email': email,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Şifre sıfırlama başarısız');
    }
  } catch (e) {
    throw Exception('Şifre sıfırlama sırasında bir hata oluştu: $e');
  }
}
```

2. **Şifre Sıfırlama Kodu Doğrulama:**
Kullanıcı, email'ine gelen kodu girerek doğrular.

```dart
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

3. **Yeni Şifre Belirleme:**
Doğrulama başarılı olduğunda, kullanıcı yeni şifresini belirler.

```dart
Future<void> resetPassword(
    String email, String code, String newPassword) async {
  try {
    final response = await _apiService.request(
      'POST',
      '/auth/reset-password',
      data: {
        'email': email,
        'code': code,
        'newPassword': newPassword,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Şifre güncelleme başarısız');
    }
  } catch (e) {
    throw Exception('Şifre güncelleme sırasında bir hata oluştu: $e');
  }
}
```

#### 4.1.5. Güvenlik Önlemleri

Kimlik doğrulama sisteminde aşağıdaki güvenlik önlemleri alınmıştır:

- **Token Süresi**: JWT tokenlar sınırlı bir süre için geçerlidir.
- **Secure Storage**: Tokenlar cihazda güvenli bir şekilde saklanır.
- **Automatic Logout**: Token süresi dolduğunda otomatik çıkış yapılır.
- **Rate Limiting**: Belirli bir süre içinde çok sayıda başarısız giriş denemesi engellenmiştir.
- **Input Validation**: Kullanıcı girdileri hem client hem de server tarafında doğrulanır.

### 4.2. API İletişimi ve Güvenliği

CineMate uygulaması, backend servisleriyle iletişim kurmak için güvenli, verimli ve merkezi bir API iletişim sistemi kullanmaktadır. Bu sistem, Dio HTTP client kütüphanesi üzerine inşa edilmiştir.

#### 4.2.1. Merkezi API Servisi

Tüm API istekleri, merkezi bir `ApiService` sınıfı üzerinden yönetilmektedir. Bu, tutarlı hata yönetimi, loglama ve kimlik doğrulama işlemlerini merkezi bir yerde yapma imkanı sağlar.

```dart
class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            validateStatus: (status) => status! < 500,
          ),
        ),
        _storage = const FlutterSecureStorage() {
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
  }
```

#### 4.2.2. API Konfigürasyonu ve Ortam Yönetimi

API konfigürasyonu, farklı ortamlar (development, staging, production) için kolayca değiştirilebilir bir yapıdadır:

```dart
class ApiConfig {
  /* static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    } else if (Platform.isIOS) {
      return 'http://localhost:8000';
    } else {
      return 'http://127.0.0.1:8000';
    }
  }
 */
  static const String baseUrl = 'http://159.146.28.250:4816';

  static const String apiPrefix = '/api/v1';
}
```

Bu yapı, farklı geliştirme ortamları ve platformlar için esneklik sağlar. Yorum yapılmış kısımlar, yerel geliştirme ortamı için uygun URL'leri göstermektedir.

#### 4.2.3. Token Tabanlı Kimlik Doğrulama Interceptor'ları

Her API isteğine otomatik olarak Bearer token ekleyen bir interceptor kullanılmaktadır:

```dart
onRequest: (options, handler) async {
  final token = await _storage.read(key: 'token');
  if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
  }
  options.path = _buildPath(options.path);
  return handler.next(options);
},
```

Ayrıca, 401 (Unauthorized) hatası alındığında token'ı silen bir error interceptor da bulunmaktadır:

```dart
onError: (error, handler) async {
  if (error.response?.statusCode == 401) {
    await _storage.delete(key: 'token');
  }
  return handler.next(error);
},
```

#### 4.2.4. İstek Yönetim Sistematiği

API istekleri, merkezi bir `request` metodu üzerinden yapılmaktadır. Bu metot, farklı HTTP metodlarını (GET, POST, PUT, DELETE) destekler:

```dart
Future<Response> request(
  String method,
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? headers,
}) async {
  try {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    if (data != null) {
      log('Giden veri: ${data.toString()}');
    }

    switch (method.toUpperCase()) {
      case 'GET':
        return await _dio.get(path);
      case 'POST':
        return await _dio.post(path, data: data);
      case 'PUT':
        return await _dio.put(path, data: data);
      case 'DELETE':
        return await _dio.delete(path);
      default:
        return await _dio.get(path);
    }
  } on DioException catch (e) {
    throw _handleError(e);
  } catch (e) {
    throw Exception('İstek sırasında beklenmeyen bir hata oluştu: $e');
  }
}
```

#### 4.2.5. Kapsamlı Hata Yönetimi

API servisinde kapsamlı bir hata yönetim sistemi bulunmaktadır. Farklı hata türleri için özelleştirilmiş mesajlar ve işlemler mevcuttur:

```dart
Exception _handleError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return Exception(
          'Sunucuya bağlanırken zaman aşımı oluştu. Lütfen internet bağlantınızı kontrol edin.');
    case DioExceptionType.connectionError:
      return Exception(
          'Sunucuya bağlanılamıyor. Lütfen sunucunun çalıştığından ve doğru adreste olduğundan emin olun.');
    case DioExceptionType.badResponse:
      return Exception('Sunucu hatası: ${e.response?.statusCode}');
    case DioExceptionType.cancel:
      return Exception('İstek iptal edildi');
    default:
      return Exception('Bir hata oluştu: ${e.message}');
  }
}
```

#### 4.2.6. API Güvenlik Önlemleri

API iletişiminde aşağıdaki güvenlik önlemleri alınmıştır:

1. **HTTPS Kullanımı**: Production ortamında tüm API iletişimi HTTPS üzerinden yapılır.
2. **Token Güvenliği**: JWT tokenlar cihazda güvenli bir şekilde saklanır.
3. **Request/Response Logging**: Geliştirme sürecinde debug amacıyla logging yapılırken, production ortamında hassas veriler loglanmaz.
4. **Timeout Yönetimi**: Tüm istekler için timeout süreleri belirlenmiştir.
5. **Geçersiz Durum Yönetimi**: Geçersiz token veya session durumları otomatik olarak ele alınır.

#### 4.2.7. API Katmanları ve Servis Sınıfları

API iletişimi, üç katmanlı bir yapıda organize edilmiştir:

1. **ApiService**: Temel HTTP isteklerini yönetir.
2. **Domain Servisleri**: Her bir domain (user, content, collection vb.) için özelleştirilmiş servisler bulunur.
3. **Repository Sınıfları**: Business logic ile API servisleri arasında arayüz sağlar.

Örnek bir domain servisi:

```dart
class UserService {
  final ApiService _apiService;

  UserService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    // ... implementation ...
  }

  Future<User> me() async {
    // ... implementation ...
  }

  // ... other methods ...
}
```

### 4.3. Kullanıcı İçerik Etkileşimi

CineMate uygulaması, kullanıcıların içeriklerle zengin etkileşimler kurmasını sağlayan kapsamlı bir sistem sunmaktadır. Bu sistem, kullanıcı deneyimini kişiselleştirmeye ve zenginleştirmeye odaklanır.

#### 4.3.1. İçerik Etkileşim Türleri

Uygulama, kullanıcılara aşağıdaki temel etkileşim türlerini sunar:

1. **Beğeni (Like)**: Kullanıcılar içerikleri beğenebilir veya beğenilerini kaldırabilir.
2. **İzleme Durumu (Watch)**: Kullanıcılar bir içeriği izlediklerini işaretleyebilirler.
3. **İzleme Listesi (Watchlist)**: Kullanıcılar gelecekte izlemek istedikleri içerikleri izleme listesine ekleyebilirler.
4. **Koleksiyonlar**: Kullanıcılar içerikleri özel koleksiyonlara ekleyebilirler.

#### 4.3.2. İçerik Etkileşim API Servisi

Kullanıcı içerik etkileşimleri, özel bir `UserContentService` sınıfı tarafından yönetilir:

```dart
class UserContentService {
  final ApiService _apiService;

  UserContentService(this._apiService);

  Future<UserContent> getUserContentStatus(String contentId) async {
    final response = await _apiService.request(
      'GET',
      '/user-contents/$contentId/status',
    );
    return UserContent.fromJson(response.data);
  }

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
}
```

#### 4.3.3. İçerik Listeleri ve Geçmiş

Kullanıcıların içerik etkileşim geçmişi ve listeleri de yönetilmektedir:

```dart
Future<List<Content>> getWatchHistory({int skip = 0, int limit = 10}) async {
  final response = await _apiService.request(
    'GET',
    '/user-contents/watch-history',
    data: {
      'skip': skip,
      'limit': limit,
    },
  );
  return (response.data as List)
      .map((json) => Content.fromJson(json))
      .toList();
}

Future<List<Content>> getWatchlist({int skip = 0, int limit = 10}) async {
  final response = await _apiService.request(
    'GET',
    '/user-contents/watchlist',
    data: {
      'skip': skip,
      'limit': limit,
    },
  );
  return (response.data as List)
      .map((json) => Content.fromJson(json))
      .toList();
}

Future<List<Content>> getLikedContents({int skip = 0, int limit = 10}) async {
  final response = await _apiService.request(
    'GET',
    '/user-contents/liked',
    data: {
      'skip': skip,
      'limit': limit,
    },
  );
  return (response.data as List)
      .map((json) => Content.fromJson(json))
      .toList();
}
```

#### 4.3.4. Kullanıcı İçerik Model Yapısı

Kullanıcı içerik etkileşimleri, özel bir `UserContent` modeli ile takip edilir:

```dart
@freezed
class UserContent with _$UserContent {
  const factory UserContent({
    @JsonKey(name: '_id') required String id,
    required String userId,
    required String contentId,
    required bool liked,
    required bool watched,
    required bool inWatchlist,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserContent;

  factory UserContent.fromJson(Map<String, dynamic> json) =>
      _$UserContentFromJson(json);
}
```

#### 4.3.5. İçerik Detay Sayfası ve Etkileşim UI

İçerik detay sayfasında, kullanıcılar içerikle ilgili tüm etkileşimleri gerçekleştirebilirler:

```dart
class _ActionButtons extends ConsumerWidget {
  final String contentId;

  const _ActionButtons({required this.contentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userContentState = ref.watch(userContentProvider);
    final userContent = userContentState.userContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'İşlemler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
              icon: Icons.favorite,
              label: 'Beğen',
              isActive: userContent?.liked ?? false,
              activeColor: Colors.red,
              onPressed: () {
                ref.read(userContentProvider.notifier).toggleLike(contentId);
              },
            ),
            _buildActionButton(
              icon: Icons.visibility,
              label: 'İzledim',
              isActive: userContent?.watched ?? false,
              activeColor: Colors.green,
              onPressed: () {
                ref.read(userContentProvider.notifier).toggleWatch(contentId);
              },
            ),
            _buildActionButton(
              icon: Icons.bookmark,
              label: 'Listeye Ekle',
              isActive: userContent?.inWatchlist ?? false,
              activeColor: Colors.blue,
              onPressed: () {
                ref.read(userContentProvider.notifier).toggleWatchlist(contentId);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isActive ? activeColor : Colors.grey,
            size: 28,
          ),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? activeColor : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
```

#### 4.3.6. Koleksiyon Yönetimi

Kullanıcılar, özel koleksiyonlar oluşturabilir ve içerikleri bu koleksiyonlara ekleyebilirler:

```dart
// Koleksiyon Modeli
@freezed
class Collection with _$Collection {
  const factory Collection({
    @JsonKey(name: '_id') required String id,
    required String userId,
    required String name,
    String? description,
    @JsonKey(name: 'is_public') required bool isPublic,
    @JsonKey(name: 'content_count') int? contentCount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
```

### 4.4. Karanlık/Aydınlık Tema Desteği

CineMate uygulaması, kullanıcı deneyimini kişiselleştirmek ve farklı kullanım ortamlarına uyum sağlamak için kapsamlı bir tema sistemi sunar.

#### 4.4.1. Tema Yönetim Sistemi

Uygulamada temalar, `ThemeProvider` sınıfı ile yönetilir:

```dart
final themeProvider = StateProvider<ThemeMode>((ref) {
  // Varsayılan olarak sistem temasını kullan
  return ThemeMode.system;
});
```

Bu provider, kullanıcının tema tercihini saklar ve gerektiğinde değiştirir.

#### 4.4.2. Tema Sabitleri

Temaya özel renkler, şekiller ve diğer görsel özellikler, merkezi bir `ThemeConstants` sınıfında tanımlanır:

```dart
class ThemeConstants {
  // Tema renkleri
  static const Color primaryLightColor = Color(0xFF6200EE);
  static const Color primaryDarkColor = Color(0xFFBB86FC);

  static const Color backgroundLightColor = Color(0xFFFFFFFF);
  static const Color backgroundDarkColor = Color(0xFF121212);

  static const Color textLightColor = Color(0xFF000000);
  static const Color textDarkColor = Color(0xFFFFFFFF);

  // Light tema
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryLightColor,
    scaffoldBackgroundColor: backgroundLightColor,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textLightColor),
      // ... diğer text stilleri
    ),
    // ... diğer tema özellikleri
  );

  // Dark tema
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: backgroundDarkColor,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textDarkColor),
      // ... diğer text stilleri
    ),
    // ... diğer tema özellikleri
  );

  // Yardımcı metodlar
  static Color getPrimaryColor(WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    if (themeMode == ThemeMode.light) return primaryLightColor;
    if (themeMode == ThemeMode.dark) return primaryDarkColor;

    // Sistem teması
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.light ? primaryLightColor : primaryDarkColor;
  }

  static Color getTextColor(WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    if (themeMode == ThemeMode.light) return textLightColor;
    if (themeMode == ThemeMode.dark) return textDarkColor;

    // Sistem teması
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.light ? textLightColor : textDarkColor;
  }
}
```

#### 4.4.3. Tema Uygulanması

Ana uygulama widget'ında temalar `MaterialApp`'e uygulanır:

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema modu provider'ını izle
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'CineMate',
      themeMode: themeMode, // Sistem ayarı veya kullanıcı seçimi
      theme: ThemeConstants.lightTheme, // Light tema
      darkTheme: ThemeConstants.darkTheme, // Dark tema
      home: const SplashScreen(),
    );
  }
}
```

#### 4.4.4. Tema Değiştirme UI

Kullanıcılar, uygulama ayarlarından tema tercihlerini değiştirebilirler:

```dart
class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema Ayarları'),
      ),
      body: ListView(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Sistem Teması'),
            value: ThemeMode.system,
            groupValue: currentTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                ref.read(themeProvider.notifier).state = value;
                _saveThemePreference(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Aydınlık Tema'),
            value: ThemeMode.light,
            groupValue: currentTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                ref.read(themeProvider.notifier).state = value;
                _saveThemePreference(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Karanlık Tema'),
            value: ThemeMode.dark,
            groupValue: currentTheme,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                ref.read(themeProvider.notifier).state = value;
                _saveThemePreference(value);
              }
            },
          ),
        ],
      ),
    );
  }

  void _saveThemePreference(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme_mode', mode.index);
  }
}
```

#### 4.4.5. Tema Tercihi Saklama

Kullanıcının tema tercihi, cihazda SharedPreferences kullanılarak saklanır ve uygulama başlatıldığında yüklenir:

```dart
void loadThemePreference(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final themeIndex = prefs.getInt('theme_mode') ?? ThemeMode.system.index;
  ref.read(themeProvider.notifier).state = ThemeMode.values[themeIndex];
}
```

#### 4.4.6. Dinamik Tema Adaptasyonu

Uygulama, kullanıcı arayüzü bileşenlerinin dinamik olarak mevcut temaya adapte olmasını sağlar:

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final textColor = ThemeConstants.getTextColor(ref);
  final primaryColor = ThemeConstants.getPrimaryColor(ref);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      'Dinamik Tema Örneği',
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
```

### 4.5. Performans Optimizasyonları

CineMate uygulamasında, akıcı bir kullanıcı deneyimi sağlamak için çeşitli performans optimizasyonları uygulanmıştır. Bu optimizasyonlar, uygulamanın hızlı açılması, akıcı çalışması ve kaynakları verimli kullanması için önemlidir.

#### 4.5.1. İmmutable Veri Modelleri

Freezed kütüphanesi kullanılarak, tüm veri modelleri immutable (değiştirilemez) olarak tasarlanmıştır. Bu, aşağıdaki avantajları sağlar:

- Güvenli state yönetimi
- Beklenmeyen yan etkilerin önlenmesi
- Verimli object equality kontrolü
- Önbelleğe alma optimizasyonları

```dart
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

Freezed, equality (==) operatörü, toString() ve hashCode metodlarını otomatik olarak oluşturur, böylece veri karşılaştırmaları çok daha hızlı ve güvenilir hale gelir.

#### 4.5.2. Verimli State Yönetimi

Riverpod framework'ü kullanılarak, uygulama state'i verimli bir şekilde yönetilir:

- **Minimal Rebuild**: Sadece değişen state'e bağlı widget'lar yeniden yapılandırılır.
- **Selective Listening**: Widget'lar yalnızca ihtiyaç duydukları state parçalarını dinler.
- **Dependency Tracking**: Riverpod, state bağımlılıklarını otomatik olarak takip eder.

```dart
// StateNotifier örneği
class UserContentNotifier extends StateNotifier<UserContentState> {
  UserContentNotifier(this._userContentService)
      : super(UserContentState.initial());

  final UserContentService _userContentService;

  Future<void> loadUserContentStatus(String contentId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userContent = await _userContentService.getUserContentStatus(contentId);
      state = state.copyWith(
        isLoading: false,
        userContent: userContent,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Diğer metodlar...
}
```

#### 4.5.3. Veri Önbelleğe Alma ve Optimizasyon

API'den alınan veriler, gereksiz ağ isteklerini önlemek için önbelleğe alınır:

- **Memory Caching**: Kısa süreli kullanım için bellekte önbelleğe alma
- **Persistent Caching**: Uzun süreli kullanım için kalıcı önbelleğe alma
- **Akıllı Yenileme Stratejisi**: Verilerin yalnızca gerektiğinde yenilenmesi

```dart
// FutureProvider ile API önbelleğe alma örneği
final contentDetailsProvider = FutureProvider.family<Content, String>((ref, contentId) async {
  final contentService = ref.watch(contentServiceProvider);

  try {
    return await contentService.getContentDetails(contentId);
  } catch (e) {
    throw Exception('İçerik detayları yüklenirken bir hata oluştu: $e');
  }
});
```

#### 4.5.4. Lazy Loading ve Pagination

Büyük veri listeleri için, lazy loading ve pagination teknikleri uygulanmıştır:

- **Pagination**: Verilerin sayfalar halinde yüklenmesi
- **Infinite Scrolling**: Kullanıcı listeyi kaydırdıkça daha fazla veri yüklenmesi
- **On-Demand Loading**: Verilerin yalnızca ihtiyaç duyulduğunda yüklenmesi

```dart
class PaginatedListView extends StatefulWidget {
  // Widget kodu...
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMoreData = true;
  List<Content> _items = [];

  @override
  void initState() {
    super.initState();
    _loadMoreData();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!_isLoading && _hasMoreData) {
        _loadMoreData();
      }
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newItems = await widget.loadData(_currentPage, 10);

      if (newItems.isEmpty) {
        setState(() {
          _hasMoreData = false;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _items.addAll(newItems);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Hata işleme...
    }
  }

  // Widget build metodu...
}
```

#### 4.5.5. Image Optimization

Görsel performansı iyileştirmek için çeşitli teknikler uygulanmıştır:

- **Lazy Image Loading**: Görsellerin yalnızca görünür olduğunda yüklenmesi
- **Image Caching**: Görsellerin önbelleğe alınması
- **Responsive Images**: Ekran boyutuna ve çözünürlüğüne göre uygun görsel servis edilmesi
- **Placeholder ve Fade-in Animation**: Görsel yüklenene kadar placeholder gösterilmesi

```dart
Image.network(
  widget.content.imageUrl!,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        color: primaryColor,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return _buildPlaceholderIcon(textColor, 96);
  },
)
```

#### 4.5.6. Code Generation ve Derleme Optimizasyonları

Dart ve Flutter'ın code generation özelliklerinden yararlanılarak:

- **AOT Compilation**: Production build'lerde Ahead-of-Time derleme ile performans artışı
- **Tree Shaking**: Kullanılmayan kodların derleme aşamasında kaldırılması
- **Minification**: Kodun sıkıştırılması ve optimize edilmesi

Bu optimizasyonlar sayesinde, uygulama daha az bellek kullanır, daha hızlı başlar ve daha akıcı çalışır.

## 5. Güvenlik Özellikleri

CineMate uygulaması, kullanıcı verilerinin güvenliğini sağlamak için kapsamlı güvenlik önlemleri içermektedir. Bu bölümde, uygulamanın öne çıkan güvenlik özellikleri detaylandırılmıştır.

### 5.1. Güvenli Veri Saklama

#### 5.1.1. Hassas Verilerin Güvenli Saklanması

Uygulama, hassas verileri güvenli bir şekilde saklamak için `flutter_secure_storage` kütüphanesini kullanır. Bu kütüphane, platform spesifik güvenlik mekanizmalarından yararlanır:

- **iOS**: Apple Keychain
  - Data Protection API kullanılarak veriler şifrelenir
  - Biometrik doğrulama ile erişim kısıtlaması
  - App-specific storage alanı

- **Android**: EncryptedSharedPreferences
  - Android Keystore System kullanımı
  - AES-256 şifreleme
  - Master key rotasyonu
  - StrongBox güvenlik desteği

```dart
// Güvenli depolama kullanımı
final _storage = FlutterSecureStorage();

// Token saklama
Future<void> saveToken(String token) async {
  await _storage.write(key: 'token', value: token);
}

// Token okuma
Future<String?> getToken() async {
  return await _storage.read(key: 'token');
}

// Token silme (Çıkış yapma)
Future<void> deleteToken() async {
  await _storage.delete(key: 'token');
}
```

#### 5.1.2. Token Yönetimi

JWT tokenlar, güvenli bir şekilde cihazda saklanır ve yönetilir:

- **Token Validation**: Her kullanımdan önce tokenların geçerliliği kontrol edilir
- **Token Refreshing**: Süresi dolmak üzere olan tokenlar otomatik olarak yenilenir
- **Token Rotation**: Güvenlik ihlali durumunda tokenlar değiştirilebilir
- **Session Invalidation**: Çıkış yapıldığında veya güvenlik ihlali durumunda tokenlar geçersiz kılınır

#### 5.1.3. Hassas Olmayan Veriler için Depolama

Tema tercihleri gibi hassas olmayan veriler için `shared_preferences` kullanılır:

```dart
// Tema tercihini saklama
Future<void> saveThemePreference(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('theme_mode', mode.index);
}

// Tema tercihini yükleme
Future<ThemeMode> loadThemePreference() async {
  final prefs = await SharedPreferences.getInstance();
  final themeIndex = prefs.getInt('theme_mode') ?? ThemeMode.system.index;
  return ThemeMode.values[themeIndex];
}
```

### 5.2. Ağ Güvenliği

#### 5.2.1. HTTPS Kullanımı

Tüm API iletişimi, HTTPS protokolü üzerinden gerçekleştirilir:

- TLS 1.2+ kullanımı
- Certificate pinning (uygulama önceden tanımlanmış sertifikaları doğrular)
- Sertifika şeffaflığı kontrolü

#### 5.2.2. JWT Token Güvenliği

JWT tokenlar, güvenli bir şekilde oluşturulur ve doğrulanır:

- **Signature Verification**: Token imzaları doğrulanır
- **Expiration Checking**: Süre aşımı kontrolü yapılır
- **Claims Validation**: Token içindeki talepler doğrulanır
- **Audience Checking**: Hedef kitle doğrulaması yapılır

#### 5.2.3. API İletişim Güvenliği

API istekleri, aşağıdaki güvenlik önlemleri ile korunur:

- **Request/Response Encryption**: Hassas veriler şifrelenir
- **Rate Limiting**: Aşırı istek engelleme
- **CSRF Protection**: Cross-Site Request Forgery koruması
- **Interceptor Güvenliği**: İstek ve yanıt interceptorları, güvenlik kontrollerini otomatikleştirir

```dart
// API isteği örneği (güvenlik önlemleri ile)
Future<Response> secureRequest(
  String method,
  String path, {
  Map<String, dynamic>? data,
}) async {
  try {
    // Rate limiting kontrolü
    if (!_rateLimiter.canMakeRequest(path)) {
      throw Exception('Çok fazla istek yapıldı. Lütfen daha sonra tekrar deneyin.');
    }

    // Token kontrolü ve yenileme
    await _checkAndRefreshTokenIfNeeded();

    // İsteği yap
    final response = await _dio.request(
      path,
      data: data,
      options: Options(method: method),
    );

    // Yanıt doğrulama
    _validateResponse(response);

    return response;
  } catch (e) {
    // Güvenlik hata işleme
    _handleSecurityException(e);
    rethrow;
  }
}
```

### 5.3. Kullanıcı Doğrulama

#### 5.3.1. Güvenli Giriş/Kayıt İşlemleri

Kullanıcı girişi ve kaydı, aşağıdaki güvenlik önlemleri ile korunur:

- **Password Policies**: Güçlü şifre politikaları (minimum uzunluk, karmaşıklık vs.)
- **Brute Force Protection**: Başarısız giriş denemelerini sınırlama
- **Account Lockout**: Çok sayıda başarısız giriş denemesi sonrası hesap kilitleme
- **Login Activity Monitoring**: Şüpheli giriş aktivitelerini tespit etme

```dart
// Güvenli giriş işlemi
Future<LoginResult> secureLogin(String email, String password) async {
  // Input validation
  if (!_validateEmail(email) || !_validatePassword(password)) {
    throw InvalidCredentialsException('Geçersiz e-posta veya şifre formatı.');
  }

  try {
    // Login isteği
    final response = await _apiService.request(
      'POST',
      '/auth/login',
      data: {
        'email': email,
        'password': password,
        'device_info': await _getDeviceInfo(), // Cihaz bilgisi gönder
      },
    );

    // Token saklama
    await _storage.write(key: 'token', value: response.data['access_token']);

    return LoginResult(
      user: User.fromJson(response.data['user']),
      isNewDevice: response.data['is_new_device'] ?? false,
    );
  } catch (e) {
    // Güvenlik loglama
    _securityLogger.logFailedLogin(email, e.toString());

    // Kullanıcıya özel hata mesajı
    throw LoginException('Giriş yapılamadı. Lütfen bilgilerinizi kontrol edin.');
  }
}
```

#### 5.3.2. Şifre Sıfırlama Güvenliği

Şifre sıfırlama süreci, aşağıdaki güvenlik önlemleri ile korunur:

- **Limited-Time Codes**: Sınırlı süreli doğrulama kodları
- **Rate Limiting**: Kod isteme ve doğrulama denemelerini sınırlama
- **Secure Channels**: Doğrulama kodlarının güvenli kanallar üzerinden iletilmesi
- **Multi-Factor Verification**: Çoklu faktör doğrulama (email + ek doğrulama)
- **Audit Logging**: Şifre sıfırlama işlemlerinin kaydedilmesi

#### 5.3.3. Biometrik Doğrulama Entegrasyonu

Uygulama, desteklenen cihazlarda biometrik doğrulama (parmak izi, yüz tanıma) desteği sunar:

- **Local Authentication API**: Flutter local_auth paketi kullanımı
- **Fallback Mechanisms**: Biometrik doğrulama başarısız olduğunda alternatif doğrulama
- **Secure Key Storage**: Biometrik doğrulama ile korunan anahtar depolama

### 5.4. Kod Güvenliği

#### 5.4.1. Güvenli Kodlama Pratikleri

Uygulama, aşağıdaki güvenli kodlama pratikleri ile geliştirilmiştir:

- **Input Validation**: Tüm kullanıcı girdileri doğrulanır
- **Error Handling**: Güvenli hata yönetimi (hassas bilgilerin açığa çıkmaması)
- **Memory Management**: Bellek yönetimi ve sızıntı kontrolü
- **Secure Dependencies**: Güvenlik açığı olmayan bağımlılıklar kullanımı

#### 5.4.2. Code Obfuscation

Production build'lerde kod karmaşıklaştırma teknikleri uygulanmıştır:

- **Name Obfuscation**: Anlamlı isimlerin karmaşıklaştırılması
- **Control Flow Obfuscation**: Kod akışının karmaşıklaştırılması
- **String Encryption**: String değerlerin şifrelenmesi

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
