import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final int currentIndex;

  HomeState({
    this.isLoading = false,
    this.error,
    this.currentIndex = 0,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    int? currentIndex,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(HomeState());

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}

final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
  (ref) => HomeStateNotifier(),
);
