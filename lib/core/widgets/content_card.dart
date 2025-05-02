import 'package:flutter/material.dart';
import '../../core/constants/theme_constants.dart';
import '../../core/constants/hero_constants.dart';
import '../../core/models/content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modules/detail/screens/content_detail_page.dart';

class ContentCard extends ConsumerWidget {
  final Content content;
  final int index;
  final String sectionId;

  const ContentCard({
    super.key,
    required this.content,
    required this.index,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardColor = ThemeConstants.getSurfaceColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);

    // Benzersiz source tag oluştur
    final String contentId = content.id ?? 'unknown';
    final String sourceTag = '${sectionId}_$index';

    // Hero tag'i için HeroConstants kullan
    final String heroTag = HeroConstants.contentImageTag(contentId, sourceTag);

    return GestureDetector(
      onTap: () => _navigateToDetailPage(context, contentId, sourceTag),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildImageSection(heroTag, textColor, primaryColor),
            ),
            _buildInfoSection(textColor),
          ],
        ),
      ),
    );
  }

  /// Detay sayfasına yönlendirme işlemi
  void _navigateToDetailPage(
      BuildContext context, String contentId, String sourceTag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentDetailPage(
          content: content,
          contentId: contentId,
          sourceTag: sourceTag,
        ),
      ),
    );
  }

  /// Kartın görsel kısmını oluşturur
  Widget _buildImageSection(
      String heroTag, Color textColor, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Stack(
        children: [
          _buildImage(heroTag, textColor, primaryColor),
          _buildTypeLabel(textColor),
        ],
      ),
    );
  }

  /// İçerik resmi veya placeholder oluşturur
  Widget _buildImage(String heroTag, Color textColor, Color primaryColor) {
    if (content.imageUrl == null || content.imageUrl!.isEmpty) {
      return Center(
        child: Icon(
          content.type == true ? Icons.tv : Icons.movie,
          color: textColor.withOpacity(0.3),
          size: 48,
        ),
      );
    }

    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: Image.network(
          content.imageUrl!,
          width: double.infinity,
          height: double.infinity,
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
            return Center(
              child: Icon(
                content.type == true ? Icons.tv : Icons.movie,
                color: textColor.withOpacity(0.3),
                size: 48,
              ),
            );
          },
        ),
      ),
    );
  }

  /// Film/Dizi etiketi oluşturur
  Widget _buildTypeLabel(Color textColor) {
    final bool isDizi = content.type == true;

    return Positioned(
      top: 4,
      right: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: isDizi
              ? Colors.blue.withOpacity(0.8)
              : Colors.orange.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          isDizi ? 'Dizi' : 'Film',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Başlık ve bilgileri içeren alt kısmı oluşturur
  Widget _buildInfoSection(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.title ?? '',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                content.averageRating?.toStringAsFixed(1) ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              const Spacer(),
              Text(
                content.year.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
