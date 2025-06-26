import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/movie/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

// 1. Sayfanın tüm verisini tutacak olan state sınıfı
@freezed
class MovieDetailScreenState with _$MovieDetailScreenState {
  const factory MovieDetailScreenState({
    Movie? movie,
    @Default([]) List<Movie> relatedMovies,
  }) = _MovieDetailScreenState;
}

// 2. State'i, Notifier'ı ve Provider'ı tanımlama
final movieDetailProvider = StateNotifierProvider.autoDispose
    .family<MovieDetailNotifier, AsyncValue<MovieDetailScreenState>, String>(
        (ref, movieId) {
  final movieService = ref.watch(movieServiceProvider);
  return MovieDetailNotifier(movieService, movieId);
});

class MovieDetailNotifier
    extends StateNotifier<AsyncValue<MovieDetailScreenState>> {
  final MovieService _movieService;
  final String _movieId;

  MovieDetailNotifier(this._movieService, this._movieId)
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

      state = AsyncValue.data(MovieDetailScreenState(
        movie: movie,
        relatedMovies: relatedMovies,
      ));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  // 3. Aksiyon Metodları
  Future<void> toggleLike() async {
    if (state.value?.movie == null) return;
    final originalMovie = state.value!.movie!;

    final newLikedState = !originalMovie.isLiked;
    final newLikesCount = originalMovie.numLikes + (newLikedState ? 1 : -1);

    // Optimistic UI update
    state = AsyncValue.data(state.value!.copyWith(
        movie: originalMovie.copyWith(
      isLiked: newLikedState,
      numLikes: newLikesCount,
    )));

    try {
      await _movieService.toggleInteraction(_movieId, InteractionType.like);
    } catch (e) {
      // Revert on error
      state = AsyncValue.data(state.value!.copyWith(movie: originalMovie));
    }
  }

  Future<void> toggleWatched() async {
    if (state.value?.movie == null) return;
    final originalMovie = state.value!.movie!;

    final newWatchedState = !originalMovie.isWatched;
    final newWatchesCount =
        originalMovie.numWatches + (newWatchedState ? 1 : -1);

    // Optimistic UI update
    state = AsyncValue.data(state.value!.copyWith(
        movie: originalMovie.copyWith(
      isWatched: newWatchedState,
      numWatches: newWatchesCount,
    )));

    try {
      await _movieService.toggleInteraction(_movieId, InteractionType.watched);
    } catch (e) {
      // Revert on error
      state = AsyncValue.data(state.value!.copyWith(movie: originalMovie));
    }
  }

  Future<void> toggleWatchlist() async {
    if (state.value?.movie == null) return;
    final originalMovie = state.value!.movie!;

    state = AsyncValue.data(state.value!.copyWith(
        movie: originalMovie.copyWith(
            isInWatchlist: !originalMovie.isInWatchlist)));

    try {
      await _movieService.toggleInteraction(
          _movieId, InteractionType.watchlist);
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(movie: originalMovie));
    }
  }
}
