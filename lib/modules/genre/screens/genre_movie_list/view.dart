import 'package:cinemate_mobile/modules/genre/services/genre_service.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genreMoviesProvider = FutureProvider.autoDispose.family((
  ref,
  String genreName,
) {
  final genreService = ref.watch(genreServiceProvider);
  return genreService.getMoviesByGenre(genreName);
});

class GenreMovieListView extends ConsumerWidget {
  final String genreName;
  final Color genreColor;
  final IconData genreIcon;

  const GenreMovieListView({
    super.key,
    required this.genreName,
    required this.genreColor,
    required this.genreIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(genreMoviesProvider(genreName));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: genreColor,
        title: Row(
          children: [
            Icon(genreIcon, color: Colors.white),
            const SizedBox(width: 10),
            Text(genreName, style: const TextStyle(color: Colors.white)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: moviesAsync.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(
              child: Text("No movies to display for this genre."),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            padding: const EdgeInsets.all(10),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailView(movieId: movie.id),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}
