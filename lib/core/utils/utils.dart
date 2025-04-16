import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException(this.message);

  @override
  String toString() => 'SecureStorageException: $message';
}

class SecureStorageUtils {
  static const _storage = FlutterSecureStorage();

  // Token kaydetme
  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'token', value: token);
      developer.log('Token başarıyla kaydedildi', name: 'SecureStorage');
    } catch (e) {
      developer.log('Token kaydedilirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException('Token kaydedilirken hata oluştu: $e');
    }
  }

  // Token okuma
  static Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: 'token');
      developer.log('Token okundu: ${token != null ? 'Mevcut' : 'Bulunamadı'}',
          name: 'SecureStorage');
      return token;
    } catch (e) {
      developer.log('Token okunurken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException('Token okunurken hata oluştu: $e');
    }
  }

  // Token silme
  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'token');
      developer.log('Token başarıyla silindi', name: 'SecureStorage');
    } catch (e) {
      developer.log('Token silinirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException('Token silinirken hata oluştu: $e');
    }
  }

  // Onboarding durumunu kaydetme
  static Future<void> setOnboardingCompleted() async {
    try {
      await _storage.write(key: 'onboarding_completed', value: 'true');
      developer.log('Onboarding durumu kaydedildi', name: 'SecureStorage');
    } catch (e) {
      developer.log('Onboarding durumu kaydedilirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException(
          'Onboarding durumu kaydedilirken hata oluştu: $e');
    }
  }

  // Onboarding durumunu kontrol etme
  static Future<bool> isOnboardingCompleted() async {
    try {
      final value = await _storage.read(key: 'onboarding_completed');
      final isCompleted = value == 'true';
      developer.log(
          'Onboarding durumu kontrol edildi: ${isCompleted ? 'Tamamlandı' : 'Tamamlanmadı'}',
          name: 'SecureStorage');
      return isCompleted;
    } catch (e) {
      developer.log('Onboarding durumu kontrol edilirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException(
          'Onboarding durumu kontrol edilirken hata oluştu: $e');
    }
  }

  // Onboarding durumunu sıfırlama (test için)
  static Future<void> resetOnboarding() async {
    try {
      await _storage.delete(key: 'onboarding_completed');
      developer.log('Onboarding durumu sıfırlandı', name: 'SecureStorage');
    } catch (e) {
      developer.log('Onboarding durumu sıfırlanırken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException(
          'Onboarding durumu sıfırlanırken hata oluştu: $e');
    }
  }

  // Tüm verileri temizleme
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      developer.log('Tüm veriler başarıyla temizlendi', name: 'SecureStorage');
    } catch (e) {
      developer.log('Veriler temizlenirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException('Veriler temizlenirken hata oluştu: $e');
    }
  }
}
