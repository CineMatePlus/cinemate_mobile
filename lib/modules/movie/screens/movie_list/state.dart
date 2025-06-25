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
      final movies =
          await _movieService.getMovies(skip: _page * _limit, limit: _limit);
      state = AsyncValue.data(movies);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> fetchNextPage() async {
    if (_isLoading || _hasReachedEnd) return;

    _isLoading = true;
    _page++;

    try {
      final newMovies =
          await _movieService.getMovies(skip: _page * _limit, limit: _limit);
      if (newMovies.isEmpty) {
        _hasReachedEnd = true;
      }

      state.whenData((currentMovies) {
        state = AsyncValue.data([...currentMovies, ...newMovies]);
      });
    } catch (e) {
      //TODO: Handle error, maybe revert page count or show a snackbar
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
