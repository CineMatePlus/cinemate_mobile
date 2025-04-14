import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../models/movie_detail.dart';
import '../providers/movie_service_provider.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  final String movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  ConsumerState<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  late Future<MovieDetail> _movieDetailFuture;

  @override
  void initState() {
    super.initState();
    _movieDetailFuture =
        ref.read(movieServiceProvider).getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: const CustomAppBar(
        title: 'Film Detayı',
        showBackButton: true,
      ),
      body: FutureBuilder<MovieDetail>(
        future: _movieDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  color: ThemeConstants.textColor,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Film bulunamadı',
                style: TextStyle(
                  color: ThemeConstants.textColor,
                ),
              ),
            );
          }

          final movieDetail = snapshot.data!;
          final movie = movieDetail.movie;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      movie.backdropPath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                ThemeConstants.defaultRadius),
                            child: Image.network(
                              movie.posterPath,
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: ThemeConstants.textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${movie.releaseDate.year} • ${movie.genres.join(', ')}',
                                style: const TextStyle(
                                  color: ThemeConstants.subtitleColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: ThemeConstants.textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(ThemeConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieDetail.tagline,
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Özet',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview,
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Yönetmen',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movieDetail.director,
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Oyuncular',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movieDetail.cast.join(', '),
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Detaylar',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Süre: ${movieDetail.runtime} dakika',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Diller: ${movieDetail.languages.join(', ')}',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ülkeler: ${movieDetail.countries.join(', ')}',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bütçe: ${movieDetail.budget}',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Hasılat: ${movieDetail.revenue}',
                        style: const TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
