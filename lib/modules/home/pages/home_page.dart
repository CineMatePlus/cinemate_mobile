import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renklerini doğrudan almak:
    final textColor = ThemeConstants.getTextColor(ref);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Tüm İçerikler', _buildHorizontalList(ref), textColor),
          const SizedBox(height: 20),
          _buildSection('Filmler', _buildHorizontalList(ref), textColor),
          const SizedBox(height: 20),
          _buildSection('Diziler', _buildHorizontalList(ref), textColor),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }

  Widget _buildHorizontalList(WidgetRef ref) {
    final cardColor = ThemeConstants.getSurfaceColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'İçerik ${index + 1}',
                style: TextStyle(color: textColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
