import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinemate_mobile/core/services/api_service.dart';
import 'package:cinemate_mobile/core/services/session_store.dart';
import 'package:cinemate_mobile/core/modules/auth/service/service.dart';
import 'package:cinemate_mobile/core/modules/auth/state.dart';

class MemoryStore implements SessionStore {
  SessionTokens? value;
  @override
  Future<SessionTokens?> read() async => value;
  @override
  Future<void> write(SessionTokens tokens) async {
    value = tokens;
  }

  @override
  Future<void> clear() async {
    value = null;
  }
}

class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.handle);
  final Future<ResponseBody> Function(RequestOptions) handle;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => handle(options);
  @override
  void close({bool force = false}) {}
}

ResponseBody reply(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

void main() {
  late MemoryStore store;
  ApiService api(Future<ResponseBody> Function(RequestOptions) handle) {
    final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
    dio.httpClientAdapter = FakeAdapter(handle);
    return ApiService(dio: dio, store: store);
  }

  setUp(() {
    store = MemoryStore();
  });

  test('register accepts 201 and persists the complete session', () async {
    final service = api((request) async {
      expect(request.data['email'], 'demo@example.com');
      expect(request.data['name'], 'Demo');
      return reply(201, {
        'access_token': 'access',
        'refresh_token': 'refresh',
        'user': {
          '_id': '123',
          'email': 'demo@example.com',
          'name': 'Demo',
          'gender': 2,
          'created_at': '2026-01-01T00:00:00Z',
          'updated_at': '2026-01-01T00:00:00Z',
        },
      });
    });
    final user = await AuthService(apiService: service)
        .register('demo@example.com', 'Demo', 'password123', 2);
    expect(user.name, 'Demo');
    expect(store.value?.refreshToken, 'refresh');
  });

  test(
    'simultaneous 401 responses rotate exactly once and retry once',
    () async {
      store.value = const SessionTokens('old', 'refresh');
      var rotations = 0;
      var requests = 0;
      final service = api((request) async {
        if (request.path.endsWith('/auth/refresh')) {
          rotations++;
          expect(request.data, {'refresh_token': 'refresh'});
          await Future<void>.delayed(const Duration(milliseconds: 20));
          return reply(200, {'access_token': 'new', 'refresh_token': 'next'});
        }
        requests++;
        return request.headers['Authorization'] == 'Bearer new'
            ? reply(200, {'ok': true})
            : reply(401, {'detail': 'expired'});
      });
      await Future.wait([
        service.request('GET', '/auth/me'),
        service.request('GET', '/users/me/stats'),
      ]);
      expect(rotations, 1);
      expect(requests, 4);
      expect(store.value?.refreshToken, 'next');
    },
  );

  test('refresh rejection clears session without looping', () async {
    store.value = const SessionTokens('old', 'refresh');
    var calls = 0;
    var expired = false;
    final service = api((request) async {
      calls++;
      return reply(401, {'detail': 'invalid'});
    });
    service.onSessionExpired = () {
      expired = true;
    };
    await expectLater(
      service.request('GET', '/auth/me'),
      throwsA(isA<ApiException>()),
    );
    expect(calls, 2);
    expect(store.value, isNull);
    expect(expired, isTrue);
  });

  test(
    'network failure preserves refresh session and does not retry writes',
    () async {
      store.value = const SessionTokens('old', 'refresh');
      var calls = 0;
      final service = api((request) async {
        calls++;
        throw DioException(
          requestOptions: request,
          type: DioExceptionType.connectionTimeout,
        );
      });
      await expectLater(
        service.request('POST', '/interactions/123/like'),
        throwsA(isA<ApiException>()),
      );
      expect(calls, 1);
      expect(store.value?.refreshToken, 'refresh');
    },
  );

  test('logout revokes refresh family and clears local credentials', () async {
    store.value = const SessionTokens('old', 'refresh');
    final service = api((request) async {
      expect(request.path, '/api/v1/auth/logout');
      expect(request.data, {'refresh_token': 'refresh'});
      return reply(204, {});
    });
    await AuthService(apiService: service).logout();
    expect(store.value, isNull);
  });

  test('nullable auth errors can be cleared explicitly', () {
    const state = AuthState(
      status: AuthStatus.error,
      errorMessage: 'old error',
    );
    expect(state.copyWith(errorMessage: null).errorMessage, isNull);
    expect(state.copyWith().errorMessage, 'old error');
  });

  test('an in-flight refresh cannot restore a logged-out session', () async {
    store.value = const SessionTokens('old', 'refresh');
    final waiting = Completer<void>();
    final started = Completer<void>();
    final service = api((request) async {
      started.complete();
      await waiting.future;
      return reply(200, {'access_token': 'new', 'refresh_token': 'next'});
    });
    final refresh = service.refreshSession();
    await started.future;
    await service.clearSession();
    waiting.complete();
    expect(await refresh, isNull);
    expect(store.value, isNull);
  });
}
