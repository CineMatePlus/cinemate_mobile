import 'package:cinemate_mobile/modules/collections/screens/collection_detail/state.dart';
import 'package:cinemate_mobile/modules/collections/screens/collections_list/state.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionDetailView extends ConsumerWidget {
  final String collectionId;
  const CollectionDetailView({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(collectionDetailProvider(collectionId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: detailAsync.when(
        data: (state) {
          final collection = state.collection;
          final movies = state.movies;
          final recommendations = state.recommendations;

          return CustomScrollView(
            slivers: [
              // Header section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF0D141C),
                          ),
                        ),
                      ),
                      // Title
                      const Text(
                        'Collection Details',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF0D141C),
                        ),
                      ),
                      // Empty space for symmetry
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),

              // Collection info section with description
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF1A1A2E),
                        const Color(0xFF0F3460),
                        const Color(0xFF0F3460).withValues(alpha: 0.8),
                        const Color(0xFF0F3460).withValues(alpha: 0.6),
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Collection name
                        Text(
                          collection?.name ?? 'Collection Name',
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Description
                        Text(
                          collection?.description ?? 'This collection features a curated list of high-octane action films, showcasing thrilling stunts, intense narratives, and unforgettable characters. Perfect for adrenaline junkies and movie enthusiasts alike.',
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Creator info (full width)
                        _buildCreatorCard(
                          icon: Icons.person_outline,
                          value: collection?.ownerName ?? 'Unknown',
                          label: 'Oluşturan',
                        ),
                        const SizedBox(height: 16),
                        // Movie count and visibility status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Public/Private indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    collection?.isPublic == true
                                        ? Icons.public
                                        : Icons.lock_outline,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    collection?.isPublic == true
                                        ? 'Herkese Açık'
                                        : 'Özel',
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${collection?.movieCount ?? 0} Film',
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.movie_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Delete collection button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _showDeleteConfirmationDialog(context, ref),
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: Colors.white70,
                            ),
                            label: const Text(
                              'Koleksiyonu Sil',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Movies section title
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  child: const Text(
                    'Movies',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Color(0xFF0D141C),
                    ),
                  ),
                ),
              ),

              // Movies grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index >= movies.length) return null;
                    final movie = movies[index];
                    return Stack(
                      children: [
                        MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailView(movieId: movie.id),
                              ),
                            );
                          },
                          titleFontSize: 14.0,
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                              onPressed: () =>
                                  _showRemoveMovieConfirmationDialog(
                                    context,
                                    ref,
                                    movie.id,
                                  ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }, childCount: movies.length),
                ),
              ),

              // Recommended movies section
              if (recommendations.isNotEmpty)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                        child: const Text(
                          'Bu koleksiyona benzer filmler',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xFF0D141C),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 165,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: recommendations.length,
                          itemBuilder: (context, index) {
                            final movie = recommendations[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                width: 110,
                                height: 165,
                                child: MovieCard(
                                  movie: movie,
                                  titleFontSize: 12.0,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailView(movieId: movie.id),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
            ],
          );
        },
        loading: () => const Scaffold(
          backgroundColor: Color(0xFFF7FAFC),
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          backgroundColor: const Color(0xFFF7FAFC),
          body: Center(child: Text('Failed to load details: $error')),
        ),
      ),
    );
  }

  Widget _buildCreatorCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Koleksiyonu Sil',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFF0D141C),
            ),
          ),
          content: const Text(
            'Bu koleksiyonu silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              color: Color(0xFF4A709C),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'İptal',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A709C),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteCollection(context, ref);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sil',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCollection(BuildContext context, WidgetRef ref) async {
    try {
      final success = await ref
          .read(collectionDetailProvider(collectionId).notifier)
          .deleteCollection();

      if (success && context.mounted) {
        // Refresh collections list
        ref.invalidate(collectionsListProvider);

        // Navigate back to collections list
        context.pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Koleksiyon başarıyla silindi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showRemoveMovieConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
    String movieId,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Filmi Kaldır'),
          content: const Text(
            'Bu filmi koleksiyondan kaldırmak istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.of(context).pop();
                try {
                  await ref
                      .read(collectionDetailProvider(collectionId).notifier)
                      .removeMovieFromCollection(movieId);
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('Film koleksiyondan kaldırıldı.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Hata: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Kaldır'),
            ),
          ],
        );
      },
    );
  }
}
