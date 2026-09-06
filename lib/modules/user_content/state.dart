import 'package:cinemate_mobile/core/services/user_service.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Hangi listenin istendiğini belirtmek için Notifier'a geçilecek olan provider
final userListTypeProvider = StateProvider<UserListType>((ref) {
  // Varsayılan değer, ya da profil sayfasından tıklanan değere göre set edilecek
  return UserListType.liked;
});

// Kullanıcı film listelerini yöneten Notifier
final userContentProvider =
    StateNotifierProvider.autoDispose<
      UserContentNotifier,
      AsyncValue<List<Movie>>
    >((ref) {
      final userService = ref.watch(userServiceProvider);
      final listType = ref.watch(userListTypeProvider);
      return UserContentNotifier(userService, listType);
    });

class UserContentNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  final UserService _userService;
  final UserListType _listType;

  UserContentNotifier(this._userService, this._listType)
    : super(const AsyncValue.loading()) {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    state = const AsyncValue.loading();
    try {
      late final List<Movie> movies;
      switch (_listType) {
        case UserListType.liked:
          movies = await _userService.getLikedMovies();
          break;
        case UserListType.watchlist:
          movies = await _userService.getWatchlist();
          break;
        case UserListType.watched:
          movies = await _userService.getWatchedHistory();
          break;
      }
      if (!mounted) return;
      state = AsyncValue.data(movies);
    } catch (e, s) {
      if (!mounted) return;
      state = AsyncValue.error(e, s);
    }
  }
}
