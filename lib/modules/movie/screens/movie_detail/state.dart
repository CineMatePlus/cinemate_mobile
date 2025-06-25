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

  // 3. Aksiyon Metodları (İskelet)
  // Bu metodlar, butonlara tıklandığında çağrılacak

  Future<void> toggleLike() async {
    // Mevcut state'in data olduğundan ve içinde film olduğundan emin ol
    if (state.value?.movie == null) return;

    final currentMovie = state.value!.movie!;
    final newStatus = !currentMovie.isLiked;

    // UI'ı anında güncelle (iyimser güncelleme - optimistic update)
    state = AsyncValue.data(
      state.value!.copyWith(
        movie: currentMovie.copyWith(isLiked: newStatus),
      ),
    );

    try {
      // API'ye isteği gönder
      // await _movieService.likeMovie(currentMovie.id, isLiked: newStatus);
    } catch (e) {
      // Hata olursa UI'ı eski haline geri döndür
      state = AsyncValue.data(
        state.value!.copyWith(
          movie: currentMovie.copyWith(isLiked: !newStatus),
        ),
      );
    }
  }

  Future<void> toggleWatched() async {
    if (state.value?.movie == null) return;

    final currentMovie = state.value!.movie!;
    final newStatus = !currentMovie.isWatched;

    state = AsyncValue.data(
      state.value!.copyWith(
        movie: currentMovie.copyWith(isWatched: newStatus),
      ),
    );
    // API isteği ve hata yönetimi eklenecek
  }

  Future<void> toggleWatchlist() async {
    if (state.value?.movie == null) return;

    final currentMovie = state.value!.movie!;
    final newStatus = !currentMovie.isInWatchlist;
    state = AsyncValue.data(
      state.value!.copyWith(
        movie: currentMovie.copyWith(isInWatchlist: newStatus),
      ),
    );
    // API isteği ve hata yönetimi eklenecek
  }
}
