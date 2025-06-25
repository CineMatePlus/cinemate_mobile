/* import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/theme_constants.dart';
import '../../core/models/content.dart';
import '../user_content/user_content_list_provider.dart';
import 'collection_provider.dart';
import 'widgets/collection_card_widget.dart';

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

    // Sayfa açıldığında veri yüklemesi yap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(refresh: true);
    });
  }

  Future<void> _loadData({bool refresh = false}) async {
    if (_isLoading && !refresh) return;

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
    } catch (e) {
      debugPrint("İçerik yükleme hatası: $e");
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
                      return ContentCardWidget(
                        content: contents[index],
                        source: widget.source,
                        textColor: textColor,
                        primaryColor: primaryColor,
                        collectionId: widget.collectionId,
                      );
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
}
 */
