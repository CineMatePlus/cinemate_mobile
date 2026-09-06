import 'dart:async';

import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/movie/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Arama sonuçlarını yönetecek olan Notifier
class SearchNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  final MovieService _movieService;
  Timer? _debounceTimer;
  int _requestId = 0;
  String _lastQuery = '';
  void retry() => searchMovies(_lastQuery);

  SearchNotifier(this._movieService) : super(const AsyncValue.data([]));

  void searchMovies(String query) {
    query = query.trim();
    _lastQuery = query;
    // Kullanıcı yazmaya devam ederken önceki zamanlayıcıyı iptal et
    _debounceTimer?.cancel();
    final requestId = ++_requestId;

    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    // Yeni bir zamanlayıcı başlat
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncValue.loading();
      try {
        final movies = await _movieService.searchMovies(query);
        if (mounted && requestId == _requestId) state = AsyncValue.data(movies);
      } catch (e, s) {
        if (mounted && requestId == _requestId) state = AsyncValue.error(e, s);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

// Search Notifier Provider'ı
final searchProvider =
    StateNotifierProvider<SearchNotifier, AsyncValue<List<Movie>>>((ref) {
      final movieService = ref.watch(movieServiceProvider);
      return SearchNotifier(movieService);
    });
