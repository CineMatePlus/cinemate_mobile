import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/providers/theme_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    // Tema'ya göre renkleri ayarla
    final primaryColor = isDarkMode
        ? ThemeConstants.darkPrimaryColor
        : ThemeConstants.lightPrimaryColor;
    final textColor = isDarkMode
        ? ThemeConstants.darkTextColor
        : ThemeConstants.lightTextColor;
    final backgroundColor = isDarkMode
        ? ThemeConstants.darkSurfaceColor
        : ThemeConstants.lightSurfaceColor;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Film veya dizi ara...',
              hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
              prefixIcon: Icon(Icons.search, color: primaryColor),
              fillColor: backgroundColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
              ),
            ),
            style: TextStyle(color: textColor),
            cursorColor: primaryColor,
            onChanged: (value) {
              // TODO: Arama işlemi
            },
          ),
          const SizedBox(height: 20),
          // TODO: Arama sonuçları
          Center(
            child: Text(
              'Arama sonuçları burada gösterilecek',
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }
}
