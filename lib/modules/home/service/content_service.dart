import 'dart:developer' as developer;
import '../../../core/models/content.dart' show Content;
import '../../../core/services/api_service.dart';

class ContentService {
  final ApiService _apiService;

  ContentService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<Content>> getAllContents({int skip = 0, int limit = 10}) async {
    try {
      final endpoint = '/contents?skip=$skip&limit=$limit';

      developer.log('Tüm içerikler getiriliyor: $endpoint',
          name: 'ContentService');

      final response = await _apiService.request(
        'GET',
        endpoint,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        developer.log('Tüm içerikler başarıyla getirildi. Toplam: ${data}',
            name: 'ContentService');
        return data.map((item) => Content.fromJson(item)).toList();
      } else {
        developer.log(
            'İçerikler getirilirken hata: ${response.statusCode} - ${response.statusMessage}',
            name: 'ContentService',
            error: response.data);
        throw Exception('İçerikler yüklenirken bir hata oluştu');
      }
    } catch (e) {
      developer.log('İçerikler getirilirken istisna oluştu',
          name: 'ContentService', error: e);
      throw Exception('İçerikler yüklenirken bir hata oluştu: $e');
    }
  }

  Future<List<Content>> getMovies({int skip = 0, int limit = 10}) async {
    try {
      final endpoint = '/contents?type=false&skip=$skip&limit=$limit';

      developer.log('Filmler getiriliyor: $endpoint', name: 'ContentService');

      final response = await _apiService.request(
        'GET',
        endpoint,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        developer.log('Filmler başarıyla getirildi. Toplam: ${data.length}',
            name: 'ContentService');
        return data.map((item) => Content.fromJson(item)).toList();
      } else {
        developer.log(
            'Filmler getirilirken hata: ${response.statusCode} - ${response.statusMessage}',
            name: 'ContentService',
            error: response.data);
        throw Exception('Filmler yüklenirken bir hata oluştu');
      }
    } catch (e) {
      developer.log('Filmler getirilirken istisna oluştu',
          name: 'ContentService', error: e);
      throw Exception('Filmler yüklenirken bir hata oluştu: $e');
    }
  }

  Future<List<Content>> getSeries({int skip = 0, int limit = 10}) async {
    try {
      final endpoint = '/contents?type=true&skip=$skip&limit=$limit';

      developer.log('Diziler getiriliyor: $endpoint', name: 'ContentService');

      final response = await _apiService.request(
        'GET',
        endpoint,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        developer.log('Diziler başarıyla getirildi. Toplam: ${data.length}',
            name: 'ContentService');
        return data.map((item) => Content.fromJson(item)).toList();
      } else {
        developer.log(
            'Diziler getirilirken hata: ${response.statusCode} - ${response.statusMessage}',
            name: 'ContentService',
            error: response.data);
        throw Exception('Diziler yüklenirken bir hata oluştu');
      }
    } catch (e) {
      developer.log('Diziler getirilirken istisna oluştu',
          name: 'ContentService', error: e);
      throw Exception('Diziler yüklenirken bir hata oluştu: $e');
    }
  }

  Future<List<Content>> searchContents({
    required String query,
    bool? type,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      // Sorgu parametrelerini hazırla
      String endpoint = '/contents/search?query=$query&skip=$skip&limit=$limit';
      if (type != null) {
        endpoint += '&type=$type';
      }

      developer.log('İçerik araması yapılıyor: $endpoint',
          name: 'ContentService');

      final response = await _apiService.request(
        'GET',
        endpoint,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        developer.log(
            'Arama sonuçları başarıyla getirildi. Toplam: ${data.length}, Aranan: "$query"',
            name: 'ContentService');
        return data.map((item) => Content.fromJson(item)).toList();
      } else {
        developer.log(
            'Arama sonuçları getirilirken hata: ${response.statusCode} - ${response.statusMessage}',
            name: 'ContentService',
            error: response.data);
        throw Exception('Arama sonuçları yüklenirken bir hata oluştu');
      }
    } catch (e) {
      developer.log('Arama yapılırken istisna oluştu',
          name: 'ContentService', error: e);
      throw Exception('Arama sonuçları yüklenirken bir hata oluştu: $e');
    }
  }
}
