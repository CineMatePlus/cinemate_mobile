import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationInfo {
  final int page;
  final int size;
  final int length;
  final int lastPage;
  final int startIndex;
  final int endIndex;
  final bool hasMore;

  PaginationInfo({
    required this.page,
    required this.size,
    required this.length,
    required this.lastPage,
    required this.startIndex,
    required this.endIndex,
    required this.hasMore,
  });

  factory PaginationInfo.initial(int size) {
    return PaginationInfo(
      page: 0,
      size: size,
      length: 0,
      lastPage: 0,
      startIndex: 0,
      endIndex: 0,
      hasMore: true,
    );
  }

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] ?? 0,
      size: json['size'] ?? 50,
      length: json['length'] ?? 0,
      lastPage: json['lastPage'] ?? 0,
      startIndex: json['startIndex'] ?? 0,
      endIndex: json['endIndex'] ?? 0,
      hasMore: json['page'] < json['lastPage'],
    );
  }

  PaginationInfo copyWith({
    int? page,
    int? size,
    int? length,
    int? lastPage,
    int? startIndex,
    int? endIndex,
    bool? hasMore,
  }) {
    return PaginationInfo(
      page: page ?? this.page,
      size: size ?? this.size,
      length: length ?? this.length,
      lastPage: lastPage ?? this.lastPage,
      startIndex: startIndex ?? this.startIndex,
      endIndex: endIndex ?? this.endIndex,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ApiResponse<T> {
  final List<T> items;
  final PaginationInfo pagination;

  ApiResponse({required this.items, required this.pagination});
}

class CoreListState<T> {
  CoreListState({
    required this.items,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
    required this.paginationInfo,
    this.isLoadingMore = false,
  });

  final List<T> items;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final PaginationInfo paginationInfo;
  final bool isLoadingMore;

  CoreListState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    PaginationInfo? paginationInfo,
    bool? isLoadingMore,
  }) {
    return CoreListState<T>(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      paginationInfo: paginationInfo ?? this.paginationInfo,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class CoreListStateNotifier<T> extends StateNotifier<CoreListState<T>> {
  CoreListStateNotifier({
    required this.dataProvider,
    required this.defaultPageSize,
    this.isPaginated = false,
  }) : super(
         CoreListState<T>(
           items: [],
           isLoading: false,
           hasError: false,
           paginationInfo: PaginationInfo.initial(defaultPageSize),
         ),
       );

  final Future<dynamic> Function({
    int? page,
    int? size,
    String? search,
    String? filter,
    String? sort,
    String? order,
  })
  dataProvider;
  final int defaultPageSize;
  final bool isPaginated;
  String? _search;
  String? _filter;
  String? _sort;
  String? _order;

  void setSearchParams({
    String? search,
    String? filter,
    String? sort,
    String? order,
  }) {
    _search = search;
    _filter = filter;
    _sort = sort;
    _order = order;
  }

  Future<void> fetchItems() async {
    try {
      state = state.copyWith(isLoading: true, hasError: false);
      log('Veri alınıyor...');

      if (isPaginated) {
        final response = await dataProvider(
          page: 0,
          size: state.paginationInfo.size,
          search: _search,
          filter: _filter ?? "{}",
          sort: _sort ?? "createdAt",
          order: _order ?? "desc",
        );

        final apiResponse = response as Map<String, dynamic>;
        final items = (apiResponse['items'] as List).cast<T>();
        final paginationInfo = PaginationInfo.fromJson(
          apiResponse['pagination'],
        );

        state = state.copyWith(
          items: items,
          isLoading: false,
          paginationInfo: paginationInfo,
        );
      } else {
        final items = await dataProvider() as List<T>;
        state = state.copyWith(items: items, isLoading: false);
      }

      log('Veri başarıyla alındı. Eleman sayısı: ${state.items.length}');
    } catch (e) {
      log('Veri alınırken hata oluştu: $e');
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (!isPaginated ||
        state.isLoadingMore ||
        state.isLoading ||
        !state.paginationInfo.hasMore) {
      return;
    }

    try {
      state = state.copyWith(isLoadingMore: true);
      log('Daha fazla veri alınıyor...');

      final nextPage = state.paginationInfo.page + 1;
      final response = await dataProvider(
        page: nextPage,
        size: state.paginationInfo.size,
        search: _search,
        filter: _filter ?? "{}",
        sort: _sort ?? "createdAt",
        order: _order ?? "desc",
      );

      final apiResponse = response as Map<String, dynamic>;
      final newItems = (apiResponse['items'] as List).cast<T>();
      final paginationInfo = PaginationInfo.fromJson(apiResponse['pagination']);

      final allItems = [...state.items, ...newItems];

      state = state.copyWith(
        items: allItems,
        isLoadingMore: false,
        paginationInfo: paginationInfo,
      );

      log('Ek veri başarıyla alındı. Toplam eleman sayısı: ${allItems.length}');
    } catch (e) {
      log('Ek veri alınırken hata oluştu: $e');
      state = state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  void refresh() {
    fetchItems();
  }
}

// StateNotifierProvider'ı widget.dart'tan oluşturacağız
