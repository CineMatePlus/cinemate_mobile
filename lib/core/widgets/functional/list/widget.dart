import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'state.dart';

class CoreList<T> extends ConsumerStatefulWidget {
  final Future<dynamic> Function({
    int? page,
    int? size,
    String? search,
    String? filter,
    String? sort,
    String? order,
  })
  dataProvider;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? loadingMoreWidget;
  final bool autoFetch;
  final bool refreshable;
  final bool isPaginated;
  final int? pageSize;
  final String? searchQuery;
  final String? filterJson;
  final String? sortField;
  final String? sortOrder;
  final ScrollPhysics? physics;
  final Function()? onEndReached;

  const CoreList({
    super.key,
    required this.dataProvider,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.loadingMoreWidget,
    this.autoFetch = true,
    this.refreshable = true,
    this.isPaginated = false,
    this.pageSize,
    this.searchQuery,
    this.filterJson,
    this.sortField,
    this.sortOrder,
    this.physics,
    this.onEndReached,
  });

  @override
  ConsumerState<CoreList<T>> createState() => _CoreListState<T>();
}

class _CoreListState<T> extends ConsumerState<CoreList<T>> {
  late StateNotifierProvider<CoreListStateNotifier<T>, CoreListState<T>>
  listProvider;
  bool _initialFetchDone = false;
  final ScrollController _scrollController = ScrollController();
  late final int _defaultPageSize;

  @override
  void initState() {
    super.initState();
    _initConfig();

    listProvider =
        StateNotifierProvider<CoreListStateNotifier<T>, CoreListState<T>>(
          (ref) => CoreListStateNotifier<T>(
            dataProvider: widget.dataProvider,
            defaultPageSize: _defaultPageSize,
            isPaginated: widget.isPaginated,
          ),
        );

    if (widget.isPaginated) {
      ref
          .read(listProvider.notifier)
          .setSearchParams(
            search: widget.searchQuery,
            filter: widget.filterJson,
            sort: widget.sortField,
            order: widget.sortOrder,
          );
    }

    if (widget.autoFetch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(listProvider.notifier).fetchItems();
        _initialFetchDone = true;
      });
    }

    if (widget.isPaginated) {
      _scrollController.addListener(_scrollListener);
    }
  }

  void _initConfig() {
    try {
      _defaultPageSize = widget.pageSize ?? 20;
    } catch (e) {
      _defaultPageSize = 20;
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final notifier = ref.read(listProvider.notifier);
      final state = ref.read(listProvider);

      if (!state.isLoadingMore &&
          !state.isLoading &&
          state.paginationInfo.hasMore) {
        notifier.loadMore();
        if (widget.onEndReached != null) {
          widget.onEndReached!();
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listProvider);

    if (state.isLoading && state.items.isEmpty) {
      return widget.loadingWidget ??
          const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return widget.errorWidget ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Hata: ${state.errorMessage ?? "Bilinmeyen hata"}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(listProvider.notifier).refresh(),
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          );
    }

    if (!widget.autoFetch && !_initialFetchDone) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Veri yüklemek için dokunun'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(listProvider.notifier).fetchItems();
                _initialFetchDone = true;
              },
              child: const Text('Verileri Yükle'),
            ),
          ],
        ),
      );
    }

    if (state.items.isEmpty) {
      if (widget.emptyWidget != null) {
        return widget.emptyWidget!;
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Veri bulunamadı'),
            if (widget.refreshable) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(listProvider.notifier).refresh(),
                child: const Text('Yenile'),
              ),
            ],
          ],
        ),
      );
    }

    final listView = ListView.builder(
      controller: _scrollController,
      physics: widget.physics,
      itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return widget.loadingMoreWidget ??
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: CircularProgressIndicator()),
              );
        }
        if (widget.isPaginated && index == state.items.length - 1) {
          return VisibilityDetector(
            key: Key('core_list_item_visibility_detector_$index'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.1) {
                final notifier = ref.read(listProvider.notifier);
                final state = ref.read(listProvider);
                if (!state.isLoadingMore &&
                    !state.isLoading &&
                    state.paginationInfo.hasMore) {
                  notifier.loadMore();
                  if (widget.onEndReached != null) {
                    widget.onEndReached!();
                  }
                }
              }
            },
            child: widget.itemBuilder(context, state.items[index], index),
          );
        }
        return widget.itemBuilder(context, state.items[index], index);
      },
    );

    if (widget.refreshable) {
      return RefreshIndicator(
        onRefresh: () => ref.read(listProvider.notifier).fetchItems(),
        child: listView,
      );
    }

    return listView;
  }
}
