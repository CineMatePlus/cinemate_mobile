import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/constants/hero_constants.dart';
import '../../../core/models/content.dart';

class ContentDetailPage extends ConsumerWidget {
  final Content content;
  final String contentId;
  final String sourceTag;

  const ContentDetailPage({
    super.key,
    required this.content,
    required this.contentId,
    required this.sourceTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);

    // Hero tag HeroConstants ile oluşturuluyor
    final heroTag = HeroConstants.contentImageTag(contentId, sourceTag);

    return Scaffold(
      appBar: _buildAppBar(context, textColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(heroTag, textColor, primaryColor),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(textColor),
                  const SizedBox(height: 16),
                  _buildStatisticsSection(textColor, primaryColor),
                  const SizedBox(height: 24),
                  _buildDescriptionSection(textColor),
                  const SizedBox(height: 24),
                  if (content.genres != null && content.genres!.isNotEmpty)
                    _buildGenresSection(textColor, primaryColor),
                  const SizedBox(height: 24),
                  _buildActionButtons(context, textColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Uygulama çubuğu
  AppBar _buildAppBar(BuildContext context, Color textColor) {
    return AppBar(
      title: Text(
        content.title ?? 'İçerik Detayı',
        style: TextStyle(color: textColor),
      ),
      iconTheme: IconThemeData(color: textColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  /// İçerik resmi/afişi
  Widget _buildHeaderImage(
      String heroTag, Color textColor, Color primaryColor) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey.shade800,
      child: content.imageUrl != null && content.imageUrl!.isNotEmpty
          ? Hero(
              tag: heroTag,
              child: Image.network(
                content.imageUrl!,
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
              ),
            )
          : _buildPlaceholderIcon(textColor, 96),
    );
  }

  /// Başlık ve tür etiketi
  Widget _buildTitleSection(Color textColor) {
    final bool isDizi = content.type == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                content.title ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Yapım Yılı: ${content.year}',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  /// İstatistikler (Puan, Beğeni, İzlenme)
  Widget _buildStatisticsSection(Color textColor, Color primaryColor) {
    return Row(
      children: [
        _buildStatistic(
          Icons.star,
          Colors.amber,
          content.averageRating?.toStringAsFixed(1) ?? '-',
          'Puan',
          textColor,
        ),
        _buildStatistic(
          Icons.favorite,
          Colors.red,
          '${content.numLikes ?? 0}',
          'Beğeni',
          textColor,
        ),
        _buildStatistic(
          Icons.visibility,
          primaryColor,
          '${content.numWatches ?? 0}',
          'İzlenme',
          textColor,
        ),
      ],
    );
  }

  /// Açıklama bölümü
  Widget _buildDescriptionSection(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Açıklama',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content.description ?? 'Açıklama bulunmamaktadır.',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  /// Türler bölümü
  Widget _buildGenresSection(Color textColor, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Türler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: content.genres!.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                genre,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// İşlem butonları
  Widget _buildActionButtons(BuildContext context, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          Icons.favorite_border,
          'Beğen',
          textColor,
          onTap: () => _showSnackBar(context, 'İçerik beğenildi', Colors.green),
        ),
        _buildActionButton(
          Icons.visibility,
          'İzledim',
          textColor,
          onTap: () =>
              _showSnackBar(context, 'İzlendi olarak işaretlendi', Colors.blue),
        ),
        _buildActionButton(
          Icons.list_alt,
          'Listeme Ekle',
          textColor,
          onTap: () =>
              _showSnackBar(context, 'Listenize eklendi', Colors.purple),
        ),
      ],
    );
  }

  // Yardımcı metodlar

  /// Placeholder ikon
  Widget _buildPlaceholderIcon(Color textColor, double size) {
    return Center(
      child: Icon(
        content.type == true ? Icons.tv : Icons.movie,
        color: textColor.withOpacity(0.3),
        size: size,
      ),
    );
  }

  /// Snackbar gösterme yardımcı metodu
  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget _buildStatistic(
    IconData icon,
    Color iconColor,
    String value,
    String label,
    Color textColor,
  ) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color textColor, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
