import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'state.dart';

class MovieListView extends ConsumerWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(moviesProvider);

    return moviesAsync.when(
      data: (movies) {
        if (movies.isEmpty) {
          return const Center(child: Text("Gösterilecek film bulunamadı."));
        }
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(moviesProvider);
          },
          child: CustomScrollView(
            slivers: [
              _buildSectionHeader("All Movies"),
              _buildMoviesGrid(movies),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Hata: $error')),
    );
  }

  Widget _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F1417),
          ),
        ),
      ),
    );
  }

  Widget _buildMoviesGrid(List<Movie> movies) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final movie = movies[index];
            final imageUrl =
                'https://image.tmdb.org/t/p/w500${movie.posterPath}';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.movie,
                          size: 50, color: Colors.grey);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F1417),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Text(
                    movie.overview,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: const Color(0xFF5C738A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
          childCount: movies.length,
        ),
      ),
    );
  }
}
