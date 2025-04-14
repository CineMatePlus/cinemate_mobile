import 'package:flutter/material.dart';
import '../../../core/constants/theme_constants.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<int> movieIds;
  final VoidCallback onSeeAll;

  const ProfileSection({
    super.key,
    required this.title,
    required this.movieIds,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeConstants.defaultPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: ThemeConstants.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text(
                  'Tümünü Gör',
                  style: TextStyle(
                    color: ThemeConstants.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConstants.defaultPadding,
            ),
            itemCount: movieIds.length,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: ThemeConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(
                    ThemeConstants.defaultRadius,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ThemeConstants.defaultRadius,
                        ),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/placeholder.jpg', // TODO: Replace with actual movie poster
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Film ${movieIds[index]}', // TODO: Replace with actual movie title
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
