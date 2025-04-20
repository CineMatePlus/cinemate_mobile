import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/models/content.dart';
import '../state/content_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // initState içinde ref.read yaparak veri yüklemeyi başlatıyoruz
    // Tüm veriler aynı anda yüklenecek
    Future.microtask(() => ref.read(contentProvider.notifier).loadAllData());
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(contentProvider);
    final textColor = ThemeConstants.getTextColor(ref);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Tüm İçerikler',
            _buildContentList(
              contentState.allContents,
              contentState.allContentsStatus,
            ),
            textColor,
          ),
          const SizedBox(height: 20),
          _buildSection(
            'Filmler',
            _buildContentList(
              contentState.movies,
              contentState.moviesStatus,
            ),
            textColor,
          ),
          const SizedBox(height: 20),
          _buildSection(
            'Diziler',
            _buildContentList(
              contentState.series,
              contentState.seriesStatus,
            ),
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }

  Widget _buildContentList(
    List<Content> contents,
    ContentLoadingStatus status,
  ) {
    final cardColor = ThemeConstants.getSurfaceColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);

    if (status == ContentLoadingStatus.loading) {
      return SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      );
    }

    if (status == ContentLoadingStatus.error) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'İçerikler yüklenirken bir hata oluştu!',
            style: TextStyle(color: ThemeConstants.errorColor),
          ),
        ),
      );
    }

    if (contents.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'İçerik bulunamadı',
            style: TextStyle(color: textColor),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: contents.length,
        itemBuilder: (context, index) {
          final content = contents[index];
          return Container(
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            content.type ? Icons.tv : Icons.movie,
                            color: textColor.withOpacity(0.3),
                            size: 48,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: content.type
                                  ? Colors.blue.withOpacity(0.8)
                                  : Colors.orange.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              content.type ? 'Dizi' : 'Film',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content.title,
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
                            content.averageRating.toStringAsFixed(1),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
