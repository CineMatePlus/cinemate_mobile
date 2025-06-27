import 'package:cinemate_mobile/core/services/user_service.dart';
import 'package:cinemate_mobile/modules/similar_users/models/similar_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarUsersProvider =
    FutureProvider.autoDispose<List<SimilarUser>>((ref) async {
  final userService = ref.watch(userServiceProvider);
  return userService.getSimilarUsers();
});
