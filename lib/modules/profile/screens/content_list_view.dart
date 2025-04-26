import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/models/content.dart';
import '../../../core/constants/hero_constants.dart';
import '../providers/user_content_list_provider.dart';
import '../providers/collection_provider.dart';
import '../../../modules/detail/pages/content_detail_page.dart';

/// İçeriklerin kaynağını belirten enum
enum ContentSource {
  liked, // Beğenilenler
  watched, // İzlenenler
  watchlist, // İzlenecekler
  collection // Özel koleksiyon
}

class ContentListView extends ConsumerStatefulWidget {
  final String title;
  final ContentSource source;
  final String? collectionId; // Eğer ContentSource.collection ise gerekli

  const ContentListView({
    Key? key,
    required this.title,
    required this.source,
    this.collectionId,
  }) : super(key: key);

  @override
  ConsumerState<ContentListView> createState() => _ContentListViewState();
}

class _ContentListViewState extends ConsumerState<ContentListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _loadData(refresh: true);
  }

  Future<void> _loadData({bool refresh = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      switch (widget.source) {
        case ContentSource.liked:
          await ref
              .read(userContentListProvider.notifier)
              .loadLikedContents(refresh: refresh);
          break;
        case ContentSource.watched:
          await ref
              .read(userContentListProvider.notifier)
              .loadWatchHistory(refresh: refresh);
          break;
        case ContentSource.watchlist:
          await ref
              .read(userContentListProvider.notifier)
              .loadWatchlist(refresh: refresh);
          break;
        case ContentSource.collection:
          if (widget.collectionId != null) {
            await ref
                .read(collectionContentsProvider(widget.collectionId!).notifier)
                .loadContents(refresh: refresh);
          }
          break;
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadData();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // İçerik listesini elde et
    final List<Content> contents = _getContents();

    // Tema renklerini doğrudan almak:
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);

    // Yükleniyor mu kontrolü
    final bool isDataLoading = _isLoadingState();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: primaryColor),
        actions: [
          IconButton(
            icon: Icon(_getSourceIcon(), color: primaryColor),
            onPressed: null,
          ),
        ],
      ),
      body: isDataLoading && contents.isEmpty
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : contents.isEmpty
              ? _buildEmptyView(textColor, primaryColor)
              : RefreshIndicator(
                  color: primaryColor,
                  backgroundColor: backgroundColor,
                  onRefresh: () => _loadData(refresh: true),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: contents.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == contents.length) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          ),
                        );
                      }
                      return _buildContentCard(
                          contents[index], textColor, primaryColor);
                    },
                  ),
                ),
    );
  }

  /// İçerik kaynağına göre uygun provider'dan içerikleri getirir
  List<Content> _getContents() {
    switch (widget.source) {
      case ContentSource.liked:
        final userContentState = ref.watch(userContentListProvider);
        return userContentState['liked'] ?? [];
      case ContentSource.watched:
        final userContentState = ref.watch(userContentListProvider);
        return userContentState['watched'] ?? [];
      case ContentSource.watchlist:
        final userContentState = ref.watch(userContentListProvider);
        return userContentState['watchlist'] ?? [];
      case ContentSource.collection:
        if (widget.collectionId != null) {
          final collectionState =
              ref.watch(collectionContentsProvider(widget.collectionId!));
          return collectionState.when(
            data: (data) => data,
            loading: () => [],
            error: (_, __) => [],
          );
        }
        return [];
    }
  }

  /// İçerik kaynağının yükleniyor durumunda olup olmadığını kontrol eder
  bool _isLoadingState() {
    if (widget.source == ContentSource.collection &&
        widget.collectionId != null) {
      final state = ref.watch(collectionContentsProvider(widget.collectionId!));
      return state is AsyncLoading;
    }
    return _isLoading;
  }

  Widget _buildEmptyView(Color textColor, Color primaryColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getSourceIcon(),
            color: textColor.withOpacity(0.5),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            '${widget.title} listenizde içerik bulunamadı',
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: Icon(Icons.refresh, color: Colors.white),
            label: Text('Yenile', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => _loadData(refresh: true),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(
      Content content, Color textColor, Color primaryColor) {
    // Her kart için benzersiz bir sourceTag oluştur
    final String sourceTag = 'list_${widget.source.name}_${content.id}';

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
                              _buildDefaultImage(primaryColor),
                        ),
                      )
                    : _buildDefaultImage(primaryColor),
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
                              isActive: widget.source == ContentSource.liked,
                            ),
                            _buildActionButton(
                              icon: Icons.visibility,
                              color: Colors.blue,
                              onTap: () => ref
                                  .read(userContentListProvider.notifier)
                                  .toggleWatch(content.id!),
                              isActive: widget.source == ContentSource.watched,
                            ),
                            _buildActionButton(
                              icon: Icons.bookmark,
                              color: Colors.purple,
                              onTap: () => ref
                                  .read(userContentListProvider.notifier)
                                  .toggleWatchlist(content.id!),
                              isActive:
                                  widget.source == ContentSource.watchlist,
                            ),
                            // Koleksiyonlar için özel işlemler
                            if (widget.source == ContentSource.collection &&
                                widget.collectionId != null)
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red.withOpacity(0.7),
                                ),
                                onPressed: () =>
                                    _removeFromCollection(content.id!),
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

  Widget _buildDefaultImage(Color primaryColor) {
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
    return widget.source == ContentSource.watched ? Icons.movie : Icons.tv;
  }

  IconData _getSourceIcon() {
    switch (widget.source) {
      case ContentSource.liked:
        return Icons.favorite;
      case ContentSource.watched:
        return Icons.visibility;
      case ContentSource.watchlist:
        return Icons.bookmark;
      case ContentSource.collection:
        return Icons.folder;
    }
  }

  void _removeFromCollection(String contentId) {
    if (widget.source == ContentSource.collection &&
        widget.collectionId != null) {
      ref
          .read(collectionContentsProvider(widget.collectionId!).notifier)
          .removeContent(contentId);
    }
  }
}
