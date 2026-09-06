import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/core/services/user_service.dart';
import 'package:cinemate_mobile/modules/collections/service/collection_service.dart';
import 'package:cinemate_mobile/modules/movie/services/service.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/search/state.dart';

import 'api_service_test.dart' show FakeAdapter, MemoryStore, reply;

class SearchService extends MovieService {
  SearchService() : super(ApiService(store: MemoryStore()));
  final pending = <String, Completer<List<Movie>>>{};
  @override
  Future<List<Movie>> searchMovies(String query) =>
      (pending[query] = Completer<List<Movie>>()).future;
}

Movie movie(String id) => Movie(
  id: id,
  title: id,
  overview: '',
  voteAverage: 5,
  releaseDate: '2020-01-01',
  genres: [],
  numLikes: 0,
  numWatches: 0,
  isLiked: false,
  isWatched: false,
  isInWatchlist: false,
);

void main() {
  test('private collection uses the snake_case backend contract', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
    dio.httpClientAdapter = FakeAdapter((request) async {
      expect(request.data['is_public'], false);
      expect(request.data.containsKey('isPublic'), false);
      return reply(201, {
        '_id': '123',
        'name': 'Private',
        'description': '',
        'owner_name': 'Demo',
        'is_public': false,
      });
    });
    final result = await CollectionService(
      ApiService(dio: dio, store: MemoryStore()),
    ).createCollection(name: 'Private', description: '', isPublic: false);
    expect(result.isPublic, false);
  });

  test('recommendations do not send unsupported pagination', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
    dio.httpClientAdapter = FakeAdapter((request) async {
      expect(request.uri.queryParameters.containsKey('skip'), false);
      expect(request.uri.queryParameters['based_on'], 'like');
      return reply(200, []);
    });
    await UserService(ApiService(dio: dio, store: MemoryStore()))
        .getRecommendations(basedOn: 'like', skip: 20);
  });

  test('late search results cannot overwrite a newer query', () async {
    final service = SearchService();
    final notifier = SearchNotifier(service);
    notifier.searchMovies('old');
    await Future<void>.delayed(const Duration(milliseconds: 550));
    notifier.searchMovies('new');
    await Future<void>.delayed(const Duration(milliseconds: 550));
    service.pending['new']!.complete([movie('new')]);
    await Future<void>.delayed(Duration.zero);
    service.pending['old']!.complete([movie('old')]);
    await Future<void>.delayed(Duration.zero);
    expect(notifier.state.value!.single.id, 'new');
    notifier.dispose();
  });

  test('clearing search invalidates an in-flight query', () async {
    final service = SearchService();
    final notifier = SearchNotifier(service);
    notifier.searchMovies('old');
    await Future<void>.delayed(const Duration(milliseconds: 550));
    notifier.searchMovies('');
    service.pending['old']!.complete([movie('old')]);
    await Future<void>.delayed(Duration.zero);
    expect(notifier.state.value, isEmpty);
    notifier.dispose();
  });
}
