import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonState {
  ButtonState({required this.isLoading, required this.isDisabled});

  final bool isLoading;
  final bool isDisabled;

  ButtonState copyWith({bool? isLoading, bool? isDisabled}) {
    return ButtonState(
      isLoading: isLoading ?? this.isLoading,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }

  Future<void> onPressed(Future<void> Function() callback) async {
    if (isLoading || isDisabled) return;

    try {
      log('onPressed try');
      await callback();
      log('onPressed try success');
    } catch (e) {
      log('onPressed error: $e');
      rethrow;
    }
  }
}

class ButtonStateNotifier extends StateNotifier<ButtonState> {
  ButtonStateNotifier()
      : super(ButtonState(isLoading: false, isDisabled: false));

  void onPressed(Future<void> Function() callback) async {
    log('onPressed');
    state = state.copyWith(isLoading: true);
    log("isLoading: ${state.isLoading}");
    await callback();
    state = state.copyWith(isLoading: false);
    log("isLoading: ${state.isLoading}");
  }

  void onSuccess() {
    state = state.copyWith(isLoading: false);
  }
}

final buttonStateNotifierProvider =
    StateNotifierProvider<ButtonStateNotifier, ButtonState>(
  (ref) => ButtonStateNotifier(),
);
