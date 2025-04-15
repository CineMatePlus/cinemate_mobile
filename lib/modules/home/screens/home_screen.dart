import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../providers/home_provider.dart';
import '../widgets/movie_list.dart';
import 'search_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: const CustomAppBar(
        title: 'Cinemate',
        showBackButton: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          homeState.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : homeState.error != null
                  ? Center(
                      child: Text(
                        homeState.error!,
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          MovieList(
                            title: 'Popüler Filmler',
                            movies: homeState.popularMovies,
                            onSeeAll: () {
                              // TODO: Navigate to popular movies screen
                            },
                          ),
                          const SizedBox(height: 32),
                          MovieList(
                            title: 'Yakında Gelecekler',
                            movies: homeState.upcomingMovies,
                            onSeeAll: () {
                              // TODO: Navigate to upcoming movies screen
                            },
                          ),
                          const SizedBox(height: 32),
                          MovieList(
                            title: 'Sizin İçin Önerilenler',
                            movies: homeState.recommendedMovies,
                            onSeeAll: () {
                              // TODO: Navigate to recommended movies screen
                            },
                          ),
                        ],
                      ),
                    ),
          const SearchScreen(),
          // const UserScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
