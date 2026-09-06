import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

typedef AutoCompleteItemBuilder = Widget Function(
  BuildContext context,
  String item,
  VoidCallback onTap,
);

typedef AutoCompleteListBuilder = Widget Function(
  BuildContext context,
  List<String> items,
  AutoCompleteItemBuilder itemBuilder,
);

class AutoCompleteItem {
  final String value;
  final String label;

  const AutoCompleteItem({required this.value, required this.label});
}

class AutoCompleteTextField extends ConsumerStatefulWidget {
  /// Arama önerileri için kullanılacak fonksiyon (zorunlu)
  /// Genellikle bir provider üzerinden erişilir:
  /// Örnek: apiProvider.getSuggestions veya apiProvider.notifier.getSuggestions
  final GetSuggestions getSuggestions;

  /// Bir seçenek seçildiğinde çağrılır
  final void Function(String selected)? onSelected;

  /// Input için dekorasyon
  final InputDecoration? decoration;

  /// FocusNode için
  final FocusNode? focusNode;

  /// Metin değiştiğinde çağrılacak callback
  final void Function(String value)? onChanged;

  /// Focus kaybında text field'ı temizle
  final bool clearOnFocusLost;

  const AutoCompleteTextField({
    super.key,
    required this.getSuggestions,
    this.onSelected,
    this.decoration,
    this.focusNode,
    this.onChanged,
    this.clearOnFocusLost = false,
  });

  @override
  ConsumerState<AutoCompleteTextField> createState() =>
      _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends ConsumerState<AutoCompleteTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _suggestions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _hideOverlay();
        if (widget.clearOnFocusLost) {
          _controller.clear();
        }
      }
    });

    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onChanged?.call(_controller.text);
    _fetchSuggestions();
  }

  Future<void> _fetchSuggestions() async {
    if (_controller.text.isEmpty) {
      _suggestions = [];
      _updateOverlay();
      return;
    }

    setState(() => _isLoading = true);
    try {
      _suggestions = await widget.getSuggestions(_controller.text);
      _updateOverlay();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 50),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: _buildSuggestionsList(),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    _hideOverlay();
    if (_suggestions.isNotEmpty) {
      _showOverlay();
    }
  }

  Widget _buildSuggestionsList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(suggestion, style: const TextStyle(fontSize: 14)),
            onTap: () {
              _controller.text = suggestion;
              _hideOverlay();
              _focusNode.unfocus();
              widget.onSelected?.call(suggestion);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration:
            widget.decoration?.copyWith(
              suffixIcon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : null,
            ) ??
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}
