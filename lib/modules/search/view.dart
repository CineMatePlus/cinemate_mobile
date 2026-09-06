import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:cinemate_mobile/modules/search/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                ref.read(searchProvider.notifier).searchMovies(query);
              },
              decoration: InputDecoration(
                hintText: 'Bir hikâye veya film konusu ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: searchResults.when(
              data: (movies) {
                if (movies.isEmpty) {
                  return const Center(child: Text('Arama sonucu bulunamadı.'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(
                      movie: movie,
                      titleFontSize: 14,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailView(movieId: movie.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(error.toString()),
                    TextButton(
                      onPressed: () =>
                          ref.read(searchProvider.notifier).retry(),
                      child: const Text('Tekrar dene'),
                    ),
                  ],
                ),
              ),
              skipLoadingOnRefresh: true,
            ),
          ),
        ],
      ),
    );
  }
}
