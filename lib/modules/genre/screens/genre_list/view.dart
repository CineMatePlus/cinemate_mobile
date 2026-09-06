import 'package:cinemate_mobile/core/constants/genre_constants.dart';
import 'package:cinemate_mobile/modules/genre/screens/genre_movie_list/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const genres = staticGenres;

    if (genres.isEmpty) {
      return const Center(child: Text("No genres to display."));
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genreName = genres[index];
        final genreColor = genreColors[index % genreColors.length];
        final genreIcon = genreIcons[genreName] ?? Icons.movie;

        return Card(
          color: genreColor,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GenreMovieListView(
                    genreName: genreName,
                    genreColor: genreColor,
                    genreIcon: genreIcon,
                  ),
                ),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(genreIcon, size: 30, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    genreName,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
