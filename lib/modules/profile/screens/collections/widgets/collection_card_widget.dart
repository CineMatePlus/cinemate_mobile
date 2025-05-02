import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/hero_constants.dart';
import '../../../../../core/models/content.dart';
import '../../../../detail/screens/content_detail_page.dart';
import '../../../../user_content/user_content_list_provider.dart';
import '../collection_provider.dart';
import '../content_list_view.dart';

/// İçerik kartı widget'ı - Koleksiyonlar, beğenilenler, izlenenler ve izlenecekler için
class ContentCardWidget extends ConsumerWidget {
  final Content content;
  final ContentSource source;
  final String? collectionId;
  final Color textColor;
  final Color primaryColor;

  const ContentCardWidget({
    Key? key,
    required this.content,
    required this.source,
    required this.textColor,
    required this.primaryColor,
    this.collectionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Her kart için benzersiz bir sourceTag oluştur
    final String sourceTag = 'list_${source.name}_${content.id}';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // İçerik detay sayfasına yönlendir
          if (content.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentDetailPage(
                  content: content,
                  contentId: content.id!,
                  sourceTag: sourceTag,
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster Görüntüsü
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: content.imageUrl != null && content.imageUrl!.isNotEmpty
                    ? Hero(
                        tag: HeroConstants.contentImageTag(
                            content.id ?? '', sourceTag),
                        child: Image.network(
                          content.imageUrl!,
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultImage(),
                        ),
                      )
                    : _buildDefaultImage(),
              ),
              const SizedBox(width: 16),
              // İçerik Bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title ?? 'İsimsiz İçerik',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (content.genres != null && content.genres!.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: content.genres!.take(3).map((genre) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 8),
                    if (content.description != null)
                      Text(
                        content.description!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 12),
                    // Alt bilgiler ve aksiyon butonları
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Yıl ve Ortalama Puan
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (content.year != null)
                              Text(
                                '${content.year}',
                                style: TextStyle(
                                  color: textColor.withOpacity(0.6),
                                  fontSize: 14,
                                ),
                              ),
                            if (content.averageRating != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${content.averageRating!.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      color: textColor.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        // İşlem butonları
                        Row(
                          children: [
                            _buildActionButton(
                              icon: Icons.favorite,
                              color: Colors.red,
                              onTap: () => ref
                                  .read(userContentListProvider.notifier)
                                  .toggleLike(content.id!),
                              isActive: source == ContentSource.liked,
                            ),
                            _buildActionButton(
                              icon: Icons.visibility,
                              color: Colors.blue,
                              onTap: () => ref
                                  .read(userContentListProvider.notifier)
                                  .toggleWatch(content.id!),
                              isActive: source == ContentSource.watched,
                            ),
                            _buildActionButton(
                              icon: Icons.bookmark,
                              color: Colors.purple,
                              onTap: () => ref
                                  .read(userContentListProvider.notifier)
                                  .toggleWatchlist(content.id!),
                              isActive: source == ContentSource.watchlist,
                            ),
                            // Koleksiyonlar için özel işlemler
                            if (source == ContentSource.collection &&
                                collectionId != null)
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red.withOpacity(0.7),
                                ),
                                onPressed: () => _removeFromCollection(ref),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultImage() {
    return Container(
      width: 100,
      height: 150,
      color: primaryColor.withOpacity(0.1),
      child: Center(
        child: Icon(
          _getContentTypeIcon(),
          color: primaryColor,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return IconButton(
      icon: Icon(
        isActive
            ? icon
            : (icon == Icons.favorite
                ? Icons.favorite_border
                : icon == Icons.visibility
                    ? Icons.visibility_outlined
                    : Icons.bookmark_border),
        color: isActive ? color : color.withOpacity(0.5),
      ),
      onPressed: onTap,
    );
  }

  IconData _getContentTypeIcon() {
    // İçerik tipine göre varsayılan ikon
    return source == ContentSource.watched ? Icons.movie : Icons.tv;
  }

  void _removeFromCollection(WidgetRef ref) {
    if (source == ContentSource.collection &&
        collectionId != null &&
        content.id != null) {
      ref
          .read(collectionContentsProvider(collectionId!).notifier)
          .removeContent(content.id!);
    }
  }
}
