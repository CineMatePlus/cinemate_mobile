import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../../utils/preferences_service.dart';
import '../models/onboarding_item.dart';

class OnboardingState {
  final bool isLoading;
  final String? error;
  final bool? isOnboardingCompleted;
  final List<OnboardingItem> items;
  final int currentPage;

  OnboardingState({
    this.isLoading = false,
    this.error,
    this.isOnboardingCompleted,
    this.items = const [],
    this.currentPage = 0,
  });

  OnboardingState copyWith({
    bool? isLoading,
    String? error,
    bool? isOnboardingCompleted,
    List<OnboardingItem>? items,
    int? currentPage,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class OnboardingStateNotifier extends StateNotifier<OnboardingState> {
  final PreferencesService _preferencesService;

  OnboardingStateNotifier({required this._preferencesService})
    : super(OnboardingState()) {
    initializeOnboardingState();
    loadOnboardingData();
  }

  Future<void> initializeOnboardingState() async {
    state = state.copyWith(isLoading: true);
    try {
      await _preferencesService.init();
      final isCompleted = await _preferencesService.isOnboardingCompleted();
      state = state.copyWith(
        isLoading: false,
        isOnboardingCompleted: isCompleted,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: error.toString(),
        isOnboardingCompleted: false,
      );
    }
  }

  Future<void> loadOnboardingData() async {
    state = state.copyWith(isLoading: true);
    try {
      final String response = await rootBundle.loadString(
        'lib/core/constants/assets/data/onboarding_data.json',
      );
      final List<dynamic> data = json.decode(response);
      final items = data.map((e) => OnboardingItem.fromJson(e)).toList();
      state = state.copyWith(isLoading: false, items: items);
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> setOnboardingCompleted() async {
    state = state.copyWith(isLoading: true);
    try {
      await _preferencesService.setOnboardingCompleted();
      state = state.copyWith(isLoading: false, isOnboardingCompleted: true);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: error.toString(),
        isOnboardingCompleted: false,
      );
    }
  }

  /// Onboarding durumunu sıfırlar (Sadece geliştirme aşamasında kullanılmalıdır)
  Future<void> resetOnboarding() async {
    state = state.copyWith(isLoading: true);
    try {
      await _preferencesService.resetOnboardingStatus();
      state = state.copyWith(
        isLoading: false,
        isOnboardingCompleted: false,
        currentPage: 0,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  void setCurrentPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final onboardingStateProvider =
    StateNotifierProvider<OnboardingStateNotifier, OnboardingState>((ref) {
      final preferencesService = ref.watch(preferencesServiceProvider);
      return OnboardingStateNotifier(preferencesService: preferencesService);
    });
