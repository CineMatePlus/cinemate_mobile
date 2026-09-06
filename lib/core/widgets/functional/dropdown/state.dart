import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropDownViewItem<T> {
  final String id;
  final String title;
  final T data;

  const DropDownViewItem({
    required this.id,
    required this.title,
    required this.data,
  });
}

class CoreDropdownState<T> {
  final Map<String, DropDownViewItem<T>> selectedItems;
  final bool isExpanded;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const CoreDropdownState({
    this.selectedItems = const {},
    this.isExpanded = false,
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  CoreDropdownState<T> copyWith({
    Map<String, DropDownViewItem<T>>? selectedItems,
    bool? isExpanded,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return CoreDropdownState<T>(
      selectedItems: selectedItems ?? this.selectedItems,
      isExpanded: isExpanded ?? this.isExpanded,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CoreDropdownNotifier<T> extends StateNotifier<CoreDropdownState<T>> {
  static final Map<String, CoreDropdownNotifier> _instances = {};

  factory CoreDropdownNotifier.instance(String id) {
    return _instances.putIfAbsent(id, () => CoreDropdownNotifier._())
        as CoreDropdownNotifier<T>;
  }

  CoreDropdownNotifier._() : super(CoreDropdownState<T>());

  void toggleItem(DropDownViewItem<T> item) {
    if (state.isLoading) return;

    final newItems = Map<String, DropDownViewItem<T>>.from(state.selectedItems);
    if (newItems.containsKey(item.id)) {
      newItems.remove(item.id);
    } else {
      newItems[item.id] = item;
    }
    state = state.copyWith(selectedItems: newItems, error: null);
  }

  void clearSelections() {
    state = state.copyWith(selectedItems: {}, error: null);
  }

  void setExpanded(bool expanded) {
    state = state.copyWith(isExpanded: expanded);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  List<DropDownViewItem<T>> getSelectedItems() {
    return state.selectedItems.values.toList();
  }

  bool isSelected(DropDownViewItem<T> item) {
    return state.selectedItems.containsKey(item.id);
  }

  @override
  void dispose() {
    _instances.remove(state);
    super.dispose();
  }
}

final coreDropdownProvider =
    StateNotifierProvider.family<
      CoreDropdownNotifier<dynamic>,
      CoreDropdownState<dynamic>,
      String
    >((ref, id) => CoreDropdownNotifier.instance(id));
