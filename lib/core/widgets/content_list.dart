import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/theme_constants.dart';
import '../../core/models/content.dart';
import '../widgets/content_card.dart';
import '../../modules/home/state/content_state.dart';

class ContentList extends ConsumerWidget {
  final List<Content> contents;
  final ContentLoadingStatus status;
  final String sectionId;

  const ContentList({
    super.key,
    required this.contents,
    required this.status,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);

    if (status == ContentLoadingStatus.loading) {
      return SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      );
    }

    if (status == ContentLoadingStatus.error) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'İçerikler yüklenirken bir hata oluştu!',
            style: TextStyle(color: ThemeConstants.errorColor),
          ),
        ),
      );
    }

    if (contents.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'İçerik bulunamadı',
            style: TextStyle(color: textColor),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: contents.length,
        itemBuilder: (context, index) {
          return ContentCard(
            content: contents[index],
            index: index,
            sectionId: sectionId,
          );
        },
      ),
    );
  }
}
