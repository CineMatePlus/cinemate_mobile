import 'package:cinemate_mobile/modules/profile/state.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_list/state.dart';
import 'package:cinemate_mobile/modules/user_content/state.dart';
import 'package:cinemate_mobile/modules/similar_users/state.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/movie/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

// 1. Sayfanın tüm verisini tutacak olan state sınıfı
@freezed
abstract class MovieDetailScreenState with _$MovieDetailScreenState {
  const factory MovieDetailScreenState({
    Movie? movie,
    @Default([]) List<Movie> relatedMovies,
  }) = _MovieDetailScreenState;
}

// 2. State'i, Notifier'ı ve Provider'ı tanımlama
final movieDetailProvider = StateNotifierProvider.autoDispose
    .family<MovieDetailNotifier, AsyncValue<MovieDetailScreenState>, String>((
      ref,
      movieId,
    ) {
      final movieService = ref.watch(movieServiceProvider);
      return MovieDetailNotifier(movieService, movieId, () {
        ref.invalidate(moviesProvider);
        ref.invalidate(userStatsProvider);
        ref.invalidate(userContentProvider);
        ref.invalidate(likedRecommendationsProvider);
        ref.invalidate(watchlistRecommendationsProvider);
        ref.invalidate(watchedRecommendationsProvider);
        ref.invalidate(similarUsersProvider);
      });
    });

class MovieDetailNotifier
    extends StateNotifier<AsyncValue<MovieDetailScreenState>> {
  final MovieService _movieService;
  final String _movieId;

  final void Function() _onChanged;
  bool _writing = false;

  MovieDetailNotifier(this._movieService, this._movieId, this._onChanged)
    : super(const AsyncValue.loading()) {
    fetchPageDetails();
  }

  // Hem film detayını hem de ilgili filmleri paralel olarak çeken metod
  Future<void> fetchPageDetails() async {
    state = const AsyncValue.loading();
    try {
      // Future.wait ile iki isteği aynı anda başlatıyoruz
      final results = await Future.wait([
        _movieService.getMovieById(_movieId),
        _movieService.getRelatedMovies(_movieId),
      ]);

      // Gelen sonuçları state'imize yerleştiriyoruz
      final movie = results[0] as Movie;
      final relatedMovies = results[1] as List<Movie>;

      if (!mounted) return;
      state = AsyncValue.data(
        MovieDetailScreenState(movie: movie, relatedMovies: relatedMovies),
      );
    } catch (e, s) {
      if (!mounted) return;
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> _toggle(InteractionType type) async {
    if (_writing || state.value?.movie == null) return;
    _writing = true;
    try {
      await _movieService.toggleInteraction(_movieId, type);
      _onChanged();
      await fetchPageDetails();
    } finally {
      _writing = false;
    }
  }

  Future<void> toggleLike() => _toggle(InteractionType.like);
  Future<void> toggleWatched() => _toggle(InteractionType.watched);
  Future<void> toggleWatchlist() => _toggle(InteractionType.watchlist);
}
