import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../states/home_state.dart';
import '../services/movie_service.dart';
import 'movie_service_provider.dart';

part 'home_provider.g.dart';

@riverpod
class Home extends _$Home {
  late final MovieService _movieService;

  @override
  HomeState build() {
    _movieService = ref.watch(movieServiceProvider);
    return const HomeState();
  }

  Future<void> loadMovies() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final popularMovies = await _movieService.getPopularMovies();
      final upcomingMovies = await _movieService.getUpcomingMovies();
      final recommendedMovies = await _movieService.getRecommendedMovies();

      state = state.copyWith(
        popularMovies: popularMovies,
        upcomingMovies: upcomingMovies,
        recommendedMovies: recommendedMovies,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
