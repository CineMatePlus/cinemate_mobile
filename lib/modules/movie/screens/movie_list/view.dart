import 'package:cinemate_mobile/modules/collections/screens/collections_list/view.dart';
import 'package:cinemate_mobile/modules/genre/screens/genre_list/view.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/view.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_list/state.dart';
import 'package:cinemate_mobile/modules/movie/widgets/horizontal_movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({super.key});

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'All Movies'),
            Tab(text: 'Collections'),
            Tab(text: 'Categories'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // All Movies Tab
              Consumer(
                builder: (context, ref, child) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(moviesProvider);
                      ref.invalidate(likedRecommendationsProvider);
                      ref.invalidate(watchlistRecommendationsProvider);
                      ref.invalidate(watchedRecommendationsProvider);
                    },
                    child: ListView(
                      children: [
                        HorizontalMovieListView(
                          title: 'All Movies',
                          moviesAsync: ref.watch(moviesProvider),
                        ),
                        HorizontalMovieListView(
                          title: 'You Might Like',
                          moviesAsync: ref.watch(likedRecommendationsProvider),
                        ),
                        HorizontalMovieListView(
                          title: 'You May Be Interested In',
                          moviesAsync:
                              ref.watch(watchlistRecommendationsProvider),
                        ),
                        HorizontalMovieListView(
                          title: 'Similar to What You Watched Before',
                          moviesAsync:
                              ref.watch(watchedRecommendationsProvider),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Collections Tab
              const CollectionsListView(),
              // Categories Tab
              const CategoriesView(),
            ],
          ),
        ),
      ],
    );
  }
}
