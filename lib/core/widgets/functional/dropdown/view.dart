import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';
import '../../../constants/colors.dart';

class CoreDropdown<T> extends ConsumerStatefulWidget {
  final List<DropDownViewItem<T>> items;
  final Widget Function(DropDownViewItem<T> item) itemBuilder;
  final Function(List<DropDownViewItem<T>> selectedItems)? onSelectionsChanged;
  final String? placeholder;
  final bool Function(DropDownViewItem<T> item, String query)? searchMatcher;
  final bool multipleSelect;
  final String dropdownId;
  final CoreDropdownTheme? theme;

  CoreDropdown({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onSelectionsChanged,
    this.placeholder,
    this.searchMatcher,
    this.multipleSelect = false,
    String? dropdownId,
    this.theme,
  }) : dropdownId = dropdownId ?? UniqueKey().toString();

  @override
  ConsumerState<CoreDropdown<T>> createState() => _CoreDropdownState<T>();
}

class _CoreDropdownState<T> extends ConsumerState<CoreDropdown<T>> {
  bool _isExpanded = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  StateNotifierProvider<
    CoreDropdownNotifier<dynamic>,
    CoreDropdownState<dynamic>
  >
  get _provider => coreDropdownProvider(widget.dropdownId);

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    ref.read(_provider.notifier).dispose();
    super.dispose();
  }

  void _handleError(String message) {
    ref.read(_provider.notifier).setError(message);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildSelectedDisplay(Map<String, DropDownViewItem<T>> selectedItems) {
    // Tekli seçimde üstte gösterme
    if (!widget.multipleSelect) return const SizedBox.shrink();
    if (selectedItems.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: selectedItems.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final item = selectedItems.values.elementAt(index);
          return Chip(
            label: widget.itemBuilder(item),
            deleteIcon: const Icon(Icons.close, size: 16),
            onDeleted: () {
              ref
                  .read(_provider.notifier)
                  .toggleItem(item as DropDownViewItem<dynamic>);
              _notifySelectionChanged();
            },
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(horizontal: 4),
          );
        },
      ),
    );
  }

  Widget _buildListItem(DropDownViewItem<T> item, bool isSelected) {
    if (widget.multipleSelect) {
      return CheckboxListTile(
        title: widget.itemBuilder(item),
        value: isSelected,
        activeColor: Theme.of(context).primaryColor,
        checkColor: Colors.white,
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (_) => _onItemSelected(item),
      );
    }

    return ListTile(
      title: widget.itemBuilder(item),
      selected: isSelected,
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).primaryColor)
          : null,
      dense: true,
      onTap: () {
        _onItemSelected(item);
        setState(() => _isExpanded = false);
      },
    );
  }

  void _onItemSelected(DropDownViewItem<T> item) {
    // Single select modunda seçili item'a tekrar basıldığında seçimi iptal et
    if (!widget.multipleSelect) {
      final isAlreadySelected = ref.read(_provider.notifier).isSelected(item);
      if (isAlreadySelected) {
        ref.read(_provider.notifier).clearSelections();
        _notifySelectionChanged();
        setState(() => _isExpanded = false);
        return;
      }
      ref.read(_provider.notifier).clearSelections();
      // Single select modunda scroll'u başa al
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    ref.read(_provider.notifier).toggleItem(item as DropDownViewItem<dynamic>);
    _notifySelectionChanged();
  }

  void _notifySelectionChanged() {
    final selectedItems = ref.read(_provider);
    final typedList = selectedItems.selectedItems.values
        .map((item) => item as DropDownViewItem<T>)
        .toList();

    widget.onSelectionsChanged?.call(typedList);
  }

  String _getDisplayText(Map<String, DropDownViewItem<T>> selectedItems) {
    if (selectedItems.isEmpty) {
      return widget.placeholder ?? 'Seçiniz';
    }
    return selectedItems.values.map((item) => item.title).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    try {
      final state = ref.watch(_provider);
      final typedItems = Map<String, DropDownViewItem<T>>.from(
        state.selectedItems.map(
          (key, value) => MapEntry(key, value as DropDownViewItem<T>),
        ),
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(state.error!, style: TextStyle(color: AppColors.red)),
            ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: state.error != null
                    ? AppColors.red
                    : widget.theme?.borderColor ?? Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(8),
              color: widget.theme?.backgroundColor ?? Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ExpansionTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getDisplayText(typedItems),
                            style:
                                widget.theme?.textStyle ??
                                TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    initiallyExpanded: _isExpanded,
                    onExpansionChanged: (expanded) =>
                        setState(() => _isExpanded = expanded),
                    children: [
                      if (typedItems.isNotEmpty && widget.multipleSelect)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: _buildSelectedDisplay(typedItems),
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Ara...',
                                prefixIcon: const Icon(Icons.search, size: 22),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              onChanged: (value) =>
                                  setState(() => _searchQuery = value),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.separated(
                                controller:
                                    _scrollController, // ScrollController ekle
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: _filteredItems.length,
                                separatorBuilder: (_, __) => Divider(
                                  height: 1,
                                  color: Colors.grey.shade200,
                                ),
                                itemBuilder: (context, index) {
                                  final item = _filteredItems[index];
                                  final isSelected = ref
                                      .read(_provider.notifier)
                                      .isSelected(item);
                                  return _buildListItem(item, isSelected);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      );
    } catch (e) {
      _handleError(e.toString());
      return const SizedBox.shrink();
    }
  }

  List<DropDownViewItem<T>> get _filteredItems {
    if (_searchQuery.isEmpty) {
      if (!widget.multipleSelect) {
        final selectedItem = ref
            .read(_provider)
            .selectedItems
            .values
            .firstOrNull;
        if (selectedItem != null) {
          final items = List<DropDownViewItem<T>>.from(widget.items);
          items.removeWhere((item) => item.id == selectedItem.id);
          return [selectedItem as DropDownViewItem<T>, ...items];
        }
      }
      return widget.items;
    }

    final filteredList = widget.items.where((item) {
      if (widget.searchMatcher != null) {
        return widget.searchMatcher!(item, _searchQuery);
      }
      return item.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return filteredList;
  }
}

class CoreDropdownTheme {
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CoreDropdownTheme({
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
  });

  static CoreDropdownTheme get defaults => CoreDropdownTheme(
    borderColor: const Color(0xFFE0E0E0),
    backgroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 15, color: Color(0xFF616161)),
  );
}
