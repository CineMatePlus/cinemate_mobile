import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/movie_service.dart';
import '../../../core/providers/api_service_provider.dart';

part 'movie_service_provider.g.dart';

@riverpod
MovieService movieService(MovieServiceRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return MovieService(apiService);
}
