import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/movie/screens/paginated_recommendations/state.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginatedRecommendationsView extends ConsumerStatefulWidget {
  final String title;
  final String recommendationType;

  const PaginatedRecommendationsView({
    super.key,
    required this.title,
    required this.recommendationType,
  });

  @override
  ConsumerState<PaginatedRecommendationsView> createState() =>
      _PaginatedRecommendationsViewState();
}

class _PaginatedRecommendationsViewState
    extends ConsumerState<PaginatedRecommendationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(
            paginatedRecommendationsProvider(widget.recommendationType)
                .notifier,
          )
          .fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesAsync = ref.watch(
      paginatedRecommendationsProvider(widget.recommendationType),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: moviesAsync.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(
              child: Text('There are no recommendations to show.'),
            );
          }
          return GridView.builder(
            controller: _scrollController,
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

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
