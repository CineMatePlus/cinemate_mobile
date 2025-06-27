import 'package:cinemate_mobile/core/services/user_service.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginatedRecommendationsNotifier
    extends StateNotifier<AsyncValue<List<Movie>>> {
  PaginatedRecommendationsNotifier(this._userService, this.basedOn)
      : super(const AsyncValue.loading()) {
    _fetchInitialMovies();
  }

  final UserService _userService;
  final String basedOn;
  int _page = 0;
  bool _isLoading = false;
  bool _hasReachedEnd = false;
  static const int _limit = 20;

  Future<void> _fetchInitialMovies() async {
    state = const AsyncValue.loading();
    _page = 0;
    _hasReachedEnd = false;
    try {
      final movies = await _userService.getRecommendations(
          basedOn: basedOn, skip: _page * _limit, limit: _limit);
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
      final newMovies = await _userService.getRecommendations(
          basedOn: basedOn, skip: _page * _limit, limit: _limit);
      if (newMovies.isEmpty) {
        _hasReachedEnd = true;
      }

      state.whenData((currentMovies) {
        state = AsyncValue.data([...currentMovies, ...newMovies]);
      });
    } catch (e) {
      // TODO: Handle error
    } finally {
      _isLoading = false;
    }
  }
}

final paginatedRecommendationsProvider = StateNotifierProvider.autoDispose
    .family<PaginatedRecommendationsNotifier, AsyncValue<List<Movie>>, String>(
        (ref, basedOn) {
  final userService = ref.watch(userServiceProvider);
  return PaginatedRecommendationsNotifier(userService, basedOn);
});
