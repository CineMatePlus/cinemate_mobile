import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/movie.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Movie> popularMovies,
    @Default([]) List<Movie> upcomingMovies,
    @Default([]) List<Movie> recommendedMovies,
    @Default(false) bool isLoading,
    String? error,
  }) = _HomeState;
}
