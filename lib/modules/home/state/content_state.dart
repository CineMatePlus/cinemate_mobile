import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/content.dart';
import '../service/content_service.dart';

enum ContentLoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

class ContentState {
  final List<Content> allContents;
  final List<Content> movies;
  final List<Content> series;
  final List<Content> searchResults;
  final ContentLoadingStatus allContentsStatus;
  final ContentLoadingStatus moviesStatus;
  final ContentLoadingStatus seriesStatus;
  final ContentLoadingStatus searchStatus;
  final String? errorMessage;
  final String searchQuery;

  ContentState({
    this.allContents = const [],
    this.movies = const [],
    this.series = const [],
    this.searchResults = const [],
    this.allContentsStatus = ContentLoadingStatus.initial,
    this.moviesStatus = ContentLoadingStatus.initial,
    this.seriesStatus = ContentLoadingStatus.initial,
    this.searchStatus = ContentLoadingStatus.initial,
    this.errorMessage,
    this.searchQuery = '',
  });

  ContentState copyWith({
    List<Content>? allContents,
    List<Content>? movies,
    List<Content>? series,
    List<Content>? searchResults,
    ContentLoadingStatus? allContentsStatus,
    ContentLoadingStatus? moviesStatus,
    ContentLoadingStatus? seriesStatus,
    ContentLoadingStatus? searchStatus,
    String? errorMessage,
    String? searchQuery,
  }) {
    return ContentState(
      allContents: allContents ?? this.allContents,
      movies: movies ?? this.movies,
      series: series ?? this.series,
      searchResults: searchResults ?? this.searchResults,
      allContentsStatus: allContentsStatus ?? this.allContentsStatus,
      moviesStatus: moviesStatus ?? this.moviesStatus,
      seriesStatus: seriesStatus ?? this.seriesStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ContentNotifier extends StateNotifier<ContentState> {
  final ContentService _contentService;

  ContentNotifier(this._contentService) : super(ContentState());

  Future<void> loadAllContents() async {
    if (state.allContentsStatus == ContentLoadingStatus.loading) return;

    state = state.copyWith(
      allContentsStatus: ContentLoadingStatus.loading,
      errorMessage: null,
    );

    try {
      final contents = await _contentService.getAllContents();
      state = state.copyWith(
        allContents: contents,
        allContentsStatus: ContentLoadingStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(
        allContentsStatus: ContentLoadingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadMovies() async {
    if (state.moviesStatus == ContentLoadingStatus.loading) return;

    state = state.copyWith(
      moviesStatus: ContentLoadingStatus.loading,
      errorMessage: null,
    );

    try {
      final movies = await _contentService.getMovies();
      state = state.copyWith(
        movies: movies,
        moviesStatus: ContentLoadingStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(
        moviesStatus: ContentLoadingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadSeries() async {
    if (state.seriesStatus == ContentLoadingStatus.loading) return;

    state = state.copyWith(
      seriesStatus: ContentLoadingStatus.loading,
      errorMessage: null,
    );

    try {
      final series = await _contentService.getSeries();
      state = state.copyWith(
        series: series,
        seriesStatus: ContentLoadingStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(
        seriesStatus: ContentLoadingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> searchContents(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(
        searchResults: [],
        searchStatus: ContentLoadingStatus.initial,
        searchQuery: '',
      );
      return;
    }

    if (state.searchStatus == ContentLoadingStatus.loading) return;

    state = state.copyWith(
      searchStatus: ContentLoadingStatus.loading,
      searchQuery: query,
      errorMessage: null,
    );

    try {
      final results = await _contentService.searchContents(query: query);
      state = state.copyWith(
        searchResults: results,
        searchStatus: ContentLoadingStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(
        searchStatus: ContentLoadingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadAllContents(),
      loadMovies(),
      loadSeries(),
    ]);
  }
}

final contentServiceProvider = Provider<ContentService>((ref) {
  return ContentService();
});

final contentProvider =
    StateNotifierProvider<ContentNotifier, ContentState>((ref) {
  final contentService = ref.watch(contentServiceProvider);
  return ContentNotifier(contentService);
});
