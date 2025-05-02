import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/constants/hero_constants.dart';
import '../../../core/models/content.dart';
import '../../user_content/user_content_provider.dart';

class ContentDetailPage extends ConsumerStatefulWidget {
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
  ConsumerState<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends ConsumerState<ContentDetailPage> {
  @override
  void initState() {
    super.initState();
    ref
        .read(userContentProvider.notifier)
        .loadUserContentStatus(widget.contentId);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);

    return Scaffold(
      appBar: _buildAppBar(context, textColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(textColor, primaryColor),
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
                  if (widget.content.genres != null &&
                      widget.content.genres!.isNotEmpty)
                    _buildGenresSection(textColor, primaryColor),
                  const SizedBox(height: 24),
                  _ActionButtons(contentId: widget.contentId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Color textColor) {
    return AppBar(
      title: Text(
        widget.content.title ?? 'İçerik Detayı',
        style: TextStyle(color: textColor),
      ),
      iconTheme: IconThemeData(color: textColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildHeaderImage(Color textColor, Color primaryColor) {
    final heroTag =
        HeroConstants.contentImageTag(widget.contentId, widget.sourceTag);

    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey.shade800,
      child:
          widget.content.imageUrl != null && widget.content.imageUrl!.isNotEmpty
              ? Hero(
                  tag: heroTag,
                  child: Image.network(
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
                  ),
                )
              : _buildPlaceholderIcon(textColor, 96),
    );
  }

  Widget _buildTitleSection(Color textColor) {
    final bool isDizi = widget.content.type == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.content.title ?? '',
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
          'Yapım Yılı: ${widget.content.year}',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(Color textColor, Color primaryColor) {
    return Row(
      children: [
        _buildStatistic(
          Icons.star,
          Colors.amber,
          widget.content.averageRating?.toStringAsFixed(1) ?? '-',
          'Puan',
          textColor,
        ),
        _buildStatistic(
          Icons.favorite,
          Colors.red,
          '${widget.content.numLikes ?? 0}',
          'Beğeni',
          textColor,
        ),
        _buildStatistic(
          Icons.visibility,
          primaryColor,
          '${widget.content.numWatches ?? 0}',
          'İzlenme',
          textColor,
        ),
      ],
    );
  }

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
          widget.content.description ?? 'Açıklama bulunmamaktadır.',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

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
          children: widget.content.genres!.map((genre) {
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

  Widget _buildPlaceholderIcon(Color textColor, double size) {
    return Center(
      child: Icon(
        widget.content.type == true ? Icons.tv : Icons.movie,
        color: textColor.withOpacity(0.3),
        size: size,
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
}

class _ActionButtons extends ConsumerWidget {
  final String contentId;

  const _ActionButtons({
    required this.contentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = ThemeConstants.getTextColor(ref);
    final userContentState = ref.watch(userContentProvider);
    final isLiked = userContentState?.isLiked ?? false;
    final isWatched = userContentState?.isWatched ?? false;
    final isInWatchlist = userContentState?.isInWatchlist ?? false;
    final isLoading = userContentState == null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: isLoading
              ? Icons.hourglass_empty
              : (isLiked ? Icons.favorite : Icons.favorite_border),
          label: 'Beğen',
          color: isLoading
              ? textColor.withOpacity(0.5)
              : (isLiked ? Colors.red : textColor),
          onTap: () {
            if (!isLoading) {
              ref.read(userContentProvider.notifier).toggleLike(contentId);
            }
          },
        ),
        _buildActionButton(
          icon: isLoading
              ? Icons.hourglass_empty
              : (isWatched ? Icons.visibility : Icons.visibility_outlined),
          label: 'İzledim',
          color: isLoading
              ? textColor.withOpacity(0.5)
              : (isWatched ? Colors.blue : textColor),
          onTap: () {
            if (!isLoading) {
              ref.read(userContentProvider.notifier).toggleWatch(contentId);
            }
          },
        ),
        _buildActionButton(
          icon: isLoading
              ? Icons.hourglass_empty
              : (isInWatchlist ? Icons.bookmark : Icons.bookmark_border),
          label: 'Listeme Ekle',
          color: isLoading
              ? textColor.withOpacity(0.5)
              : (isInWatchlist ? Colors.purple : textColor),
          onTap: () {
            if (!isLoading) {
              ref.read(userContentProvider.notifier).toggleWatchlist(contentId);
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
