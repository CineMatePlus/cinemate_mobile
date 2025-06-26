import 'package:cinemate_mobile/modules/collections/screens/collection_detail/state.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
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

              // Collection banner section
              SliverToBoxAdapter(
                child: Container(
                  height: 270,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      // Background image
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/collection_placeholders/placeholder_1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.25],
                          ),
                        ),
                      ),
                      // Collection title
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: Text(
                          collection?.name ?? 'Collection Name',
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Description section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Text(
                    collection?.description ??
                        'This collection features a curated list of high-octane action films, showcasing thrilling stunts, intense narratives, and unforgettable characters. Perfect for adrenaline junkies and movie enthusiasts alike.',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                      color: Color(0xFF0D141C),
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
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= movies.length) return null;
                      final movie = movies[index];
                      return _buildMovieCard(context, movie);
                    },
                    childCount: movies.length,
                  ),
                ),
              ),

              // Similar collections section title
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
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
              ),

              // Similar collections grid
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final titles = [
                        'Sci-Fi Thrillers',
                        'Classic Action Films',
                        'Modern War Movies'
                      ];
                      if (index >= titles.length) return null;
                      return _buildSimilarCollectionCard(
                          context, titles[index], index + 1);
                    },
                    childCount: 3,
                  ),
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
          body: Center(
            child: Text('Failed to load details: $error'),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        context.push('/movie/${movie.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie poster
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
                image: movie.posterPath != null
                    ? DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: movie.posterPath == null
                  ? const Icon(
                      Icons.movie,
                      size: 50,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          // Movie title
          Text(
            movie.title,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF0D141C),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Rating and votes
          Text(
            '${movie.voteAverage.toStringAsFixed(1)} • ${_formatVoteCount(movie.numLikes)}',
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF4A709C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarCollectionCard(
      BuildContext context, String title, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Collection image
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/collection_placeholders/placeholder_${index + 3}.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Collection title
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xFF0D141C),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatVoteCount(int voteCount) {
    if (voteCount >= 1000000) {
      return '${(voteCount / 1000000).toStringAsFixed(1)}M';
    } else if (voteCount >= 1000) {
      return '${(voteCount / 1000).toStringAsFixed(0)}K';
    } else {
      return voteCount.toString();
    }
  }
}
