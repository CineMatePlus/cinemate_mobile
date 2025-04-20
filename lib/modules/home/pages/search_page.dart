import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/models/content.dart';
import '../state/content_state.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  final _debounce = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    _debounce.run(() {
      ref.read(contentProvider.notifier).searchContents(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(contentProvider);
    final textColor = ThemeConstants.getTextColor(ref);
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final surfaceColor = ThemeConstants.getSurfaceColor(ref);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: textColor),
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  hintText: 'İçerik Ara...',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(contentProvider.notifier)
                                .searchContents('');
                          },
                          icon: Icon(Icons.clear, color: primaryColor),
                        )
                      : null,
                  filled: true,
                  fillColor: surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ThemeConstants.defaultRadius),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ThemeConstants.defaultRadius),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                ),
                onChanged: _performSearch,
              ),
            ),
            Expanded(
              child: _buildSearchResults(contentState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(ContentState state) {
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final surfaceColor = ThemeConstants.getSurfaceColor(ref);

    // Hiç arama yapılmadı
    if (state.searchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: textColor.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text('Film veya dizi ara',
                style: TextStyle(color: textColor.withOpacity(0.7))),
          ],
        ),
      );
    }

    // Yükleniyor
    if (state.searchStatus == ContentLoadingStatus.loading) {
      return Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    // Hata oluştu
    if (state.searchStatus == ContentLoadingStatus.error) {
      return Center(
        child: Text(
          'Arama sırasında bir hata oluştu',
          style: TextStyle(color: ThemeConstants.errorColor),
        ),
      );
    }

    // Sonuç bulunamadı
    if (state.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: textColor.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text(
              '"${state.searchQuery}" için sonuç bulunamadı',
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
          ],
        ),
      );
    }

    // Sonuçları listele
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.searchResults.length,
      itemBuilder: (context, index) {
        final content = state.searchResults[index];
        return _buildContentCard(content, surfaceColor, textColor);
      },
    );
  }

  Widget _buildContentCard(
      Content content, Color surfaceColor, Color textColor) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      color: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.defaultRadius),
      ),
      child: InkWell(
        onTap: () {
          // İçerik detay sayfasına yönlendirme yapılabilir
        },
        borderRadius: BorderRadius.circular(ThemeConstants.defaultRadius),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster veya placeholder
              Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade800,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        content.type ? Icons.tv : Icons.movie,
                        color: textColor.withOpacity(0.5),
                        size: 32,
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
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // İçerik bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${content.year}',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: content.genres.map((genre) {
                        return Chip(
                          label: Text(
                            genre,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor:
                              ThemeConstants.primaryColor.withOpacity(0.7),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          content.averageRating.toStringAsFixed(1),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.favorite,
                          color: Colors.red.shade400,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${content.numLikes}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                          ),
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
}

// Arama sorguları için debounce sınıfı
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
