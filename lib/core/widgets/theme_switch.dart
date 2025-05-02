import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({
    super.key,
    this.showLabel = true,
  });

  final bool showLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider.notifier);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel)
          Text(
            isDarkMode ? 'Karanlık Mod' : 'Aydınlık Mod',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(width: 8),
        Switch(
          value: isDarkMode,
          onChanged: (_) => themeNotifier.toggleTheme(),
          thumbIcon: MaterialStateProperty.resolveWith<Icon?>((states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(Icons.dark_mode, color: Colors.white);
            }
            return const Icon(Icons.light_mode);
          }),
        ),
      ],
    );
  }
}
