import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException(this.message);

  @override
  String toString() => 'SecureStorageException: $message';
}

class AuthUtils {
  static const _storage = FlutterSecureStorage();

  // Token kaydetme
  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'token', value: token);
      log('Token başarıyla kaydedildi', name: 'SecureStorage');
    } catch (e) {
      log('Token kaydedilirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException('Token kaydedilirken hata oluştu: $e');
    }
  }

  // Token okuma
  static Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: 'token');
      log('Token okundu: ${token != null ? 'Mevcut' : 'Bulunamadı'}',
          name: 'SecureStorage');
      return token;
    } catch (e) {
      log('Token okunurken hata oluştu: $e', name: 'SecureStorage', error: e);
      throw SecureStorageException('Token okunurken hata oluştu: $e');
    }
  }

  // Token silme
  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'token');
      log('Token başarıyla silindi', name: 'SecureStorage');
    } catch (e) {
      log('Token silinirken hata oluştu: $e', name: 'SecureStorage', error: e);
      throw SecureStorageException('Token silinirken hata oluştu: $e');
    }
  }

  // Tüm verileri temizleme
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      log('Tüm veriler başarıyla temizlendi', name: 'SecureStorage');
    } catch (e) {
      log('Veriler temizlenirken hata oluştu: $e',
          name: 'SecureStorage', error: e);
      throw SecureStorageException('Veriler temizlenirken hata oluştu: $e');
    }
  }
}
