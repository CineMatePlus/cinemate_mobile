import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

class CoreButton extends ConsumerWidget {
  final void Function() onPressed;
  final Widget? child;
  final bool? icon;
  final String? label;
  final IconData? iconData;

  const CoreButton(
      {super.key,
      required this.onPressed,
      this.child,
      this.icon,
      this.iconData,
      this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(buttonStateNotifierProvider);

    return icon != null && iconData != null
        ? ElevatedButton.icon(
            onPressed: () => state.onPressed(() {
              onPressed();
              return Future.value();
            }),
            icon: Icon(iconData),
            label: child != null ? child! : Text(label!),
          )
        : ElevatedButton(
            onPressed: () => state.onPressed(() {
              onPressed();
              return Future.value();
            }),
            child: label != null ? Text(label!) : child,
          );
  }
}
