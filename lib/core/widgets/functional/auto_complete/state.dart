import 'package:flutter_riverpod/flutter_riverpod.dart';

// Sadece basit bir model, gerçek uygulamada kendi model sınıfını kullanabilirsin
typedef AutoCompleteItem = String;

// Önerileri getiren fonksiyon tipi
typedef GetSuggestions = Future<List<String>> Function(String query);

// AutoComplete ayarları
class AutoCompleteSettings {
  final Duration debounce;
  final int minQueryLength;
  final int maxResults;

  const AutoCompleteSettings({
    this.debounce = const Duration(milliseconds: 300),
    this.minQueryLength = 2,
    this.maxResults = 10,
  });
}

class AutoCompleteNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final GetSuggestions getSuggestions;
  final AutoCompleteSettings settings;

  AutoCompleteNotifier({
    required this.getSuggestions,
    AutoCompleteSettings? settings,
  })  : settings = settings ?? const AutoCompleteSettings(),
        super(const AsyncValue.data([]));

  Future<void> fetchSuggestions(String query) async {
    if (query.length < settings.minQueryLength) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final suggestions = await getSuggestions(query);
      state = AsyncValue.data(
        suggestions.take(settings.maxResults).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
