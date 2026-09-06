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
  static const int _limit = 20;

  Future<void> _fetchInitialMovies() async {
    state = const AsyncValue.loading();
    _page = 0;
    try {
      final movies = await _userService.getRecommendations(
        basedOn: basedOn,
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

  // This API returns a bounded recommendation set, not offset pagination.
  Future<void> fetchNextPage() async {}
}

final paginatedRecommendationsProvider = StateNotifierProvider.autoDispose
    .family<PaginatedRecommendationsNotifier, AsyncValue<List<Movie>>, String>((
      ref,
      basedOn,
    ) {
      final userService = ref.watch(userServiceProvider);
      return PaginatedRecommendationsNotifier(userService, basedOn);
    });
