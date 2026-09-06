import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorizontalMovieListView extends ConsumerWidget {
  final String title;
  final AsyncValue<List<Movie>> moviesAsync;
  final VoidCallback? onRefresh;
  final VoidCallback? onSeeAllTapped;

  const HorizontalMovieListView({
    super.key,
    required this.title,
    required this.moviesAsync,
    this.onRefresh,
    this.onSeeAllTapped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
              if (onSeeAllTapped != null)
                InkWell(
                  onTap: onSeeAllTapped,
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 210,
          child: moviesAsync.when(
            data: (movies) {
              if (movies.isEmpty) {
                return const Center(child: Text("No movies to display."));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      width: 140,
                      child: MovieCard(
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
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Text(
                'Could not load movies. ${err.toString()}',
                softWrap: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
