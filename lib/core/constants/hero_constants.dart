/// Hero animasyonları için kullanılan sabit değerleri içeren sınıf
class HeroConstants {
  /// İçerik resimleri için hero tag formatı oluşturur
  static String contentImageTag(String contentId, String sourceId) =>
      'content_image_${contentId}_$sourceId';

  /// Content ID ve source identifier kullanarak herhangi bir içerik için tag oluşturur
  /// Bu metot farklı hero animasyonları için genişletilebilir
  static String createHeroTag(
          {required String contentId,
          required String sourceId,
          String prefix = 'content_image'}) =>
      '${prefix}_${contentId}_$sourceId';
}
