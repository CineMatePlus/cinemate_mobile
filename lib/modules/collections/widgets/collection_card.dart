import 'package:cinemate_mobile/modules/collections/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final VoidCallback onTap;

  const CollectionCard({
    super.key,
    required this.collection,
    required this.onTap,
  });

  static const List<String> _placeholderImages = [
    'lib/core/constants/assets/images/collection_placeholders/placeholder_1.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_2.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_3.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_4.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_5.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_6.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_7.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_8.png',
    'lib/core/constants/assets/images/collection_placeholders/placeholder_9.png',
  ];

  @override
  Widget build(BuildContext context) {
    final randomPlaceholder =
        _placeholderImages[Random().nextInt(_placeholderImages.length)];

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              randomPlaceholder,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.5],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${collection.movieCount} movies',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
