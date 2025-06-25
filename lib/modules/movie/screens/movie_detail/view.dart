import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/state.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailView extends ConsumerWidget {
  final String movieId;
  const MovieDetailView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsync = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      body: movieDetailAsync.when(
        data: (screenState) {
          final movie = screenState.movie;
          if (movie == null) {
            return const Center(child: Text('Film bulunamadı.'));
          }
          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(movie),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(context, movie),
                      const SizedBox(height: 16),
                      _buildActionButtons(context, ref, movieId),
                      const SizedBox(height: 24),
                      _buildOverviewSection(context, movie),
                      const SizedBox(height: 24),
                      _buildRelatedMoviesSection(
                          context, screenState.relatedMovies),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Bir hata oluştu: $error')),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(Movie movie) {
    final backdropUrl = 'https://image.tmdb.org/t/p/w780${movie.backdropPath}';
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [const Shadow(blurRadius: 2.0, color: Colors.black)],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(backdropUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '${DateTime.parse(movie.releaseDate).year}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 16),
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              movie.voteAverage.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context, WidgetRef ref, String movieId) {
    final provider = movieDetailProvider(movieId);
    final movie = ref.watch(provider).value?.movie;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButton(
          context,
          icon:
              movie?.isLiked ?? false ? Icons.favorite : Icons.favorite_border,
          label: 'Beğen',
          color: movie?.isLiked ?? false ? Colors.red : Colors.grey,
          onTap: () => ref.read(provider.notifier).toggleLike(),
        ),
        _actionButton(
          context,
          icon: movie?.isWatched ?? false
              ? Icons.visibility
              : Icons.visibility_outlined,
          label: 'İzledim',
          color: movie?.isWatched ?? false
              ? Theme.of(context).primaryColor
              : Colors.grey,
          onTap: () => ref.read(provider.notifier).toggleWatched(),
        ),
        _actionButton(
          context,
          icon: movie?.isInWatchlist ?? false
              ? Icons.bookmark
              : Icons.bookmark_border,
          label: 'Listem',
          color: movie?.isInWatchlist ?? false ? Colors.orange : Colors.grey,
          onTap: () => ref.read(provider.notifier).toggleWatchlist(),
        ),
      ],
    );
  }

  Widget _actionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, color: color, size: 28),
          splashRadius: 28,
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _buildOverviewSection(BuildContext context, Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Özet', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          movie.overview,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildRelatedMoviesSection(
      BuildContext context, List<Movie> relatedMovies) {
    if (relatedMovies.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('İlgili Filmler', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relatedMovies.length,
            itemBuilder: (context, index) {
              final movie = relatedMovies[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: MovieCard(
                    movie: movie,
                    titleFontSize: 12,
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
      ],
    );
  }
}
