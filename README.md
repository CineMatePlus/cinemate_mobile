# CineMate Mobile

CineMate servislerini kullanan Flutter mobil uygulamasıdır. Uygulama; kimlik doğrulama, içerik keşfi, arama, koleksiyonlar, yorumlar, profil ve öneri akışlarını içerir.

## Gereksinimler

- Flutter SDK
- Dart `>=3.0.0 <4.0.0`
- Çalışan CineMate backend servisi

## Kurulum ve çalıştırma

```powershell
flutter pub get
flutter run
```

Android emülatörde backend adresi `10.0.2.2:8000`, masaüstü hedeflerinde ise yerel makine adresi kullanılır. Ayarlar `lib/core/services/api_service.dart` dosyasındadır.

Freezed, Riverpod veya JSON modelleri değiştiğinde kod üretimini çalıştırın:

```powershell
dart run build_runner build --delete-conflicting-outputs
```

## Kontroller

```powershell
flutter analyze
flutter test
```

## Kaynak yapısı

| Yol | Sorumluluk |
| --- | --- |
| `lib/core/` | Ortak servisler, yönlendirme, tema ve paylaşılan bileşenler |
| `lib/modules/` | Özellik bazlı uygulama modülleri |
| `test/` | Flutter testleri |
| `docs/` | Mobil mimari ve rapor notları |

Mobil dokümantasyon haritası için [`docs/README.md`](docs/README.md) dosyasını kullanın. Yalnızca belirli bir modülün kullanımını anlatan belgeler ilgili modülün yanında kalır.

## İlgili depolar

- [Backend API](https://github.com/CineMatePlus/cinemate_backend)
- [Sistem diyagramları](https://github.com/CineMatePlus/docs)
- [Akademik raporlar](https://github.com/CineMatePlus/rapor)

## Lisans

Bu proje, telif hakkı Muhammet Berk'e ait olmak üzere [MIT License](LICENSE) ile lisanslanmıştır.
