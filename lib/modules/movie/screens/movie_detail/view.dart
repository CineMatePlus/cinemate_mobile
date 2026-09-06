import 'package:cinemate_mobile/core/modules/auth/models/user.dart';
import 'package:cinemate_mobile/core/modules/auth/state.dart';
import 'package:cinemate_mobile/core/widgets/user_avatar.dart';
import 'package:cinemate_mobile/modules/collections/service/collection_service.dart';
import 'package:cinemate_mobile/modules/comment/models/comment_with_user.dart';
import 'package:cinemate_mobile/modules/comment/state/movie_comments_state.dart';
import 'package:cinemate_mobile/modules/movie/models/movie_model.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_detail/state.dart';
import 'package:cinemate_mobile/modules/movie/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovieDetailView extends ConsumerWidget {
  final String movieId;
  const MovieDetailView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsync = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: movieDetailAsync.when(
        data: (screenState) {
          final movie = screenState.movie;
          if (movie == null) {
            return const Center(child: Text('Film bulunamadı.'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMoviePosterSection(movie),
                _buildTitleSection(context, movie),
                _buildInfoSection(context, movie),
                _buildActionButtons(context, ref, movieId),
                _buildOverviewSection(context, movie),
                _buildGenresSection(context, movie),
                _buildRelatedMoviesSection(context, screenState.relatedMovies),
                _buildCommentsSection(context, ref, movieId),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Bir hata oluştu: $error')),
      ),
    );
  }

  Widget _buildMoviePosterSection(Movie movie) {
    final path = movie.backdropPath;
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: const Color(0xFF18435B),
            child: const Icon(
              Icons.movie_outlined,
              size: 72,
              color: Colors.white54,
            ),
          ),
          if (path != null && path.isNotEmpty)
            Image.network(
              'https://image.tmdb.org/t/p/w780$path',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black38, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Builder(
              builder: (context) => BackButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _runAction(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  Widget _buildTitleSection(BuildContext context, Movie movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Text(
        movie.title,
        style: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0D141C),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Movie movie) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Text(
            DateTime.parse(movie.releaseDate).year.toString(),
            style: GoogleFonts.manrope(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 6),
          Text(
            movie.voteAverage.toStringAsFixed(1),
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    String movieId,
  ) {
    final provider = movieDetailProvider(movieId);
    final movie = ref.watch(provider).value?.movie;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _actionButton(
            context,
            icon: movie?.isLiked ?? false
                ? Icons.favorite
                : Icons.favorite_border,
            count: movie?.numLikes.toString(),
            color: const Color(0xFF4A709C),
            onTap: () => _runAction(
              context,
              () => ref.read(provider.notifier).toggleLike(),
            ),
          ),
          const SizedBox(width: 24),
          _actionButton(
            context,
            icon: movie?.isWatched ?? false
                ? Icons.visibility
                : Icons.visibility_outlined,
            count: movie?.numWatches.toString(),
            color: const Color(0xFF4A709C),
            onTap: () => _runAction(
              context,
              () => ref.read(provider.notifier).toggleWatched(),
            ),
          ),
          const SizedBox(width: 24),
          _actionButton(
            context,
            icon: movie?.isInWatchlist ?? false
                ? Icons.watch_later
                : Icons.watch_later_outlined,
            color: const Color(0xFF4A709C),
            onTap: () => _runAction(
              context,
              () => ref.read(provider.notifier).toggleWatchlist(),
            ),
          ),
          const SizedBox(width: 24),
          _actionButton(
            context,
            icon: Icons.playlist_add,
            color: const Color(0xFF4A709C),
            onTap: () => _showCollectionsBottomSheet(context, ref, movieId),
          ),
        ],
      ),
    );
  }

  void _showCollectionsBottomSheet(
    BuildContext context,
    WidgetRef ref,
    String movieId,
  ) async {
    try {
      final collections = await ref
          .read(collectionServiceProvider)
          .getMyCollections();
      if (!context.mounted) return;

      if (collections.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No collections found. Create one first!'),
          ),
        );
        return;
      }

      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                const ListTile(
                  title: Text(
                    'Add to a collection',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: collections.length,
                    itemBuilder: (BuildContext context, int index) {
                      final collection = collections[index];
                      return ListTile(
                        leading: const Icon(Icons.list),
                        title: Text(collection.name),
                        onTap: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          Navigator.of(context).pop();
                          try {
                            await ref
                                .read(collectionServiceProvider)
                                .addMovieToCollection(collection.id, movieId);
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Successfully added to ${collection.name}',
                                ),
                              ),
                            );
                          } catch (e) {
                            messenger.showSnackBar(
                              SnackBar(content: Text('Failed to add: $e')),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not fetch collections: $e')),
      );
    }
  }

  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    String? count,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 24),
            ),
            if (count != null && count.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                count,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context, Movie movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        movie.overview,
        style: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF0D141C),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildGenresSection(BuildContext context, Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Genres',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D141C),
            ),
          ),
        ),
        SizedBox(
          height: 32, // Height of the genre chips
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movie.genres.length,
            itemBuilder: (context, index) {
              return _genreChip(movie.genres[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }

  Widget _genreChip(String genre) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          genre,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0D141C),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentsSection(
    BuildContext context,
    WidgetRef ref,
    String movieId,
  ) {
    final commentsAsync = ref.watch(movieCommentsProvider(movieId));
    final textController = TextEditingController();
    final auth = ref.watch(authProvider);
    final currentUser = auth.user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Comment Input
          if (currentUser != null)
            _buildCommentInputField(
              context,
              ref,
              textController,
              currentUser,
              movieId,
            ),
          const SizedBox(height: 24),
          // Comments List
          commentsAsync.when(
            data: (comments) {
              if (comments.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('No comments yet. Be the first!'),
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                separatorBuilder: (context, index) => const Divider(height: 32),
                itemBuilder: (context, index) {
                  final commentWithUser = comments[index];
                  return _buildCommentItem(
                    context,
                    ref,
                    commentWithUser,
                    currentUser?.id,
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error loading comments: $err'),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputField(
    BuildContext context,
    WidgetRef ref,
    TextEditingController controller,
    User currentUser,
    String movieId,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(
          avatarUrl: currentUser.avatarUrl,
          gender: currentUser.gender,
          radius: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  if (controller.text.trim().isEmpty) return;
                  final text = controller.text;
                  try {
                    await ref
                        .read(movieCommentsProvider(movieId).notifier)
                        .postComment(text);
                    controller.clear();
                    if (context.mounted) FocusScope.of(context).unfocus();
                  } catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.toString())));
                    }
                  }
                },
              ),
            ),
            maxLines: null,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentItem(
    BuildContext context,
    WidgetRef ref,
    CommentWithUser commentWithUser,
    String? currentUserId,
  ) {
    final comment = commentWithUser.comment;
    final user = commentWithUser.user;
    final isAuthor = user.id == currentUserId;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(avatarUrl: user.avatarUrl, gender: user.gender, radius: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '· ${DateFormat.yMMMd().format(comment.createdAt)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(comment.text),
            ],
          ),
        ),
        if (isAuthor)
          PopupMenuButton<String>(
            tooltip: 'Yorum işlemleri',
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text('Düzenle')),
              PopupMenuItem(value: 'delete', child: Text('Sil')),
            ],
            onSelected: (action) async {
              if (action == 'delete') {
                await _runAction(
                  context,
                  () => ref
                      .read(movieCommentsProvider(movieId).notifier)
                      .deleteComment(comment.id),
                );
                return;
              }
              final controller = TextEditingController(text: comment.text);
              final edited = await showDialog<String>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Yorumu düzenle'),
                  content: TextField(
                    controller: controller,
                    maxLength: 2000,
                    maxLines: 4,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('İptal'),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          Navigator.pop(dialogContext, controller.text.trim());
                        }
                      },
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
              );
              // Let the dialog finish its exit transition before disposing its controller.
              await Future<void>.delayed(const Duration(milliseconds: 300));
              controller.dispose();
              if (edited != null && context.mounted) {
                await _runAction(
                  context,
                  () => ref
                      .read(movieCommentsProvider(movieId).notifier)
                      .updateComment(comment.id, edited),
                );
              }
            },
          ),
      ],
    );
  }

  Widget _buildRelatedMoviesSection(
    BuildContext context,
    List<Movie> relatedMovies,
  ) {
    if (relatedMovies.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'Similar Content',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D141C),
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: relatedMovies.length,
            itemBuilder: (context, index) {
              final movie = relatedMovies[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                  width: 140,
                  child: MovieCard(
                    movie: movie,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailView(movieId: movie.id),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
