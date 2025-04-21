import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/theme_constants.dart';
import '../../core/models/content.dart';
import '../widgets/content_list.dart';
import '../../modules/home/state/content_state.dart';

class ContentSection extends ConsumerWidget {
  final String title;
  final List<Content> contents;
  final ContentLoadingStatus status;
  final String sectionId;

  const ContentSection({
    super.key,
    required this.title,
    required this.contents,
    required this.status,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = ThemeConstants.getTextColor(ref);

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
        ContentList(
          contents: contents,
          status: status,
          sectionId: sectionId,
        ),
      ],
    );
  }
}
