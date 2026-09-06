import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final api = ApiService();
  ref.onDispose(api.close);
  return api;
});
