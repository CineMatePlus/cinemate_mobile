import 'package:cinemate_mobile/core/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/movie_model.dart';
import '../../services/service.dart';

// Movies Notifier
class MoviesNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  MoviesNotifier(this._movieService) : super(const AsyncValue.loading()) {
    _fetchInitialMovies();
  }

  final MovieService _movieService;
  int _page = 0;
  bool _isLoading = false;
  bool _hasReachedEnd = false;
  static const int _limit = 10;

  Future<void> _fetchInitialMovies() async {
    state = const AsyncValue.loading();
    _page = 0;
    _hasReachedEnd = false;
    try {
      final movies = await _movieService.getMovies(
        skip: _page * _limit,
        limit: _limit,
      );
      if (!mounted) return;
      state = AsyncValue.data(movies);
    } catch (e, s) {
      if (!mounted) return;
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> fetchNextPage() async {
    if (_isLoading || _hasReachedEnd) return;

    _isLoading = true;
    final nextPage = _page + 1;

    try {
      final newMovies = await _movieService.getMovies(
        skip: nextPage * _limit,
        limit: _limit,
      );
      _page = nextPage;
      if (newMovies.isEmpty) {
        _hasReachedEnd = true;
      }

      state.whenData((currentMovies) {
        if (!mounted) return;
        state = AsyncValue.data([...currentMovies, ...newMovies]);
      });
    } catch (e) {
      // Keep the current page so the next scroll retries the failed page.
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshMovies() async {
    await _fetchInitialMovies();
  }
}

// Movies Provider
final moviesProvider =
    StateNotifierProvider<MoviesNotifier, AsyncValue<List<Movie>>>((ref) {
      final movieService = ref.watch(movieServiceProvider);
      return MoviesNotifier(movieService);
    });

// Recommendation Providers
final likedRecommendationsProvider = FutureProvider<List<Movie>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.getRecommendations(basedOn: 'like');
});

final watchlistRecommendationsProvider = FutureProvider<List<Movie>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.getRecommendations(basedOn: 'watchlist');
});

final watchedRecommendationsProvider = FutureProvider<List<Movie>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.getRecommendations(basedOn: 'watched');
});
