import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../models/movie.dart';
import '../providers/movie_service_provider.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _error = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await ref.read(movieServiceProvider).searchMovies(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: const CustomAppBar(
        title: 'Film Ara',
        showBackButton: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ThemeConstants.defaultPadding),
            child: TextField(
              controller: _searchController,
              onChanged: _searchMovies,
              style: const TextStyle(color: ThemeConstants.textColor),
              decoration: InputDecoration(
                hintText: 'Film adı girin...',
                hintStyle: TextStyle(
                  color: ThemeConstants.textColor.withOpacity(0.5),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: ThemeConstants.textColor,
                ),
                filled: true,
                fillColor: ThemeConstants.secondaryColor,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(ThemeConstants.defaultRadius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _error != null
                    ? Center(
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: ThemeConstants.textColor,
                          ),
                        ),
                      )
                    : _searchResults.isEmpty
                        ? Center(
                            child: Text(
                              _searchController.text.isEmpty
                                  ? 'Film aramak için yazın'
                                  : 'Film bulunamadı',
                              style: const TextStyle(
                                color: ThemeConstants.textColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(
                                ThemeConstants.defaultPadding),
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final movie = _searchResults[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailScreen(movieId: movie.id),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: ThemeConstants.secondaryColor,
                                    borderRadius: BorderRadius.circular(
                                      ThemeConstants.defaultRadius,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          ThemeConstants.defaultRadius,
                                        ),
                                        child: Image.network(
                                          movie.posterPath,
                                          width: 80,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movie.title,
                                              style: const TextStyle(
                                                color: ThemeConstants.textColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              movie.overview,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: ThemeConstants
                                                    .subtitleColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  movie.voteAverage
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    color: ThemeConstants
                                                        .textColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Text(
                                                  movie.releaseDate.year
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: ThemeConstants
                                                        .textColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
