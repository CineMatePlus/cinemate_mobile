import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/theme_constants.dart';
import '../../core/constants/hero_constants.dart';
import '../../core/models/content.dart';
import '../../core/providers/api_service_provider.dart';
import '../auth/state.dart';
import '../user_content/user_content_provider.dart';
import '../../core/models/comment.dart';

class ContentDetailPage extends ConsumerStatefulWidget {
  final Content content;
  final String contentId;
  final String sourceTag;

  const ContentDetailPage({
    super.key,
    required this.content,
    required this.contentId,
    required this.sourceTag,
  });

  @override
  ConsumerState<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends ConsumerState<ContentDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref
        .read(userContentProvider.notifier)
        .loadUserContentStatus(widget.contentId);
    ref.read(commentProvider.notifier).loadComments(widget.contentId);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = ThemeConstants.getTextColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);

    return Scaffold(
      appBar: _buildAppBar(context, textColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(textColor, primaryColor),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(textColor),
                  const SizedBox(height: 16),
                  _buildStatisticsSection(textColor, primaryColor),
                  const SizedBox(height: 24),
                  _buildDescriptionSection(textColor),
                  const SizedBox(height: 24),
                  if (widget.content.genres != null &&
                      widget.content.genres!.isNotEmpty)
                    _buildGenresSection(textColor, primaryColor),
                  const SizedBox(height: 24),
                  _ActionButtons(contentId: widget.contentId),
                  const SizedBox(height: 24),
                  _buildCommentSection(textColor, primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Color textColor) {
    return AppBar(
      title: Text(
        widget.content.title ?? 'İçerik Detayı',
        style: TextStyle(color: textColor),
      ),
      iconTheme: IconThemeData(color: textColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildHeaderImage(Color textColor, Color primaryColor) {
    final heroTag =
        HeroConstants.contentImageTag(widget.contentId, widget.sourceTag);

    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey.shade800,
      child:
          widget.content.imageUrl != null && widget.content.imageUrl!.isNotEmpty
              ? Hero(
                  tag: heroTag,
                  child: Image.network(
                    widget.content.imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderIcon(textColor, 96);
                    },
                  ),
                )
              : _buildPlaceholderIcon(textColor, 96),
    );
  }

  Widget _buildTitleSection(Color textColor) {
    final bool isDizi = widget.content.type == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.content.title ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: isDizi
                    ? Colors.blue.withOpacity(0.8)
                    : Colors.orange.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isDizi ? 'Dizi' : 'Film',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Yapım Yılı: ${widget.content.year}',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(Color textColor, Color primaryColor) {
    return Row(
      children: [
        _buildStatistic(
          Icons.star,
          Colors.amber,
          widget.content.averageRating?.toStringAsFixed(1) ?? '-',
          'Puan',
          textColor,
        ),
        _buildStatistic(
          Icons.favorite,
          Colors.red,
          '${widget.content.numLikes ?? 0}',
          'Beğeni',
          textColor,
        ),
        _buildStatistic(
          Icons.visibility,
          primaryColor,
          '${widget.content.numWatches ?? 0}',
          'İzlenme',
          textColor,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Açıklama',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.content.description ?? 'Açıklama bulunmamaktadır.',
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildGenresSection(Color textColor, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Türler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.content.genres!.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                genre,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPlaceholderIcon(Color textColor, double size) {
    return Center(
      child: Icon(
        widget.content.type == true ? Icons.tv : Icons.movie,
        color: textColor.withOpacity(0.3),
        size: size,
      ),
    );
  }

  Widget _buildStatistic(
    IconData icon,
    Color iconColor,
    String value,
    String label,
    Color textColor,
  ) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection(Color textColor, Color primaryColor) {
    final comments = ref.watch(commentProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yorumlar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildAddCommentField(textColor, primaryColor),
        const SizedBox(height: 16),
        comments == null
            ? Center(child: CircularProgressIndicator(color: primaryColor))
            : comments.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Henüz yorum yapılmamış. İlk yorumu sen yap!',
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return _CommentItem(
                        comment: comment,
                        textColor: textColor,
                        contentId: widget.contentId,
                      );
                    },
                  ),
      ],
    );
  }

  Widget _buildAddCommentField(Color textColor, Color primaryColor) {
    final isSubmitting = ref.watch(commentProvider.notifier).isSubmitting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _commentController,
          style: TextStyle(color: textColor),
          maxLines: 3,
          minLines: 1,
          decoration: InputDecoration(
            hintText: 'Yorumunuzu yazın...',
            hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
            filled: true,
            fillColor: primaryColor.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              if (_commentController.text.trim().isNotEmpty) {
                ref.read(commentProvider.notifier).addComment(
                      widget.contentId,
                      _commentController.text.trim(),
                    );
                _commentController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: isSubmitting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Yorum Yap'),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends ConsumerWidget {
  final String contentId;

  const _ActionButtons({
    required this.contentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = ThemeConstants.getTextColor(ref);
    final userContentState = ref.watch(userContentProvider);
    final isLiked = userContentState?.isLiked ?? false;
    final isWatched = userContentState?.isWatched ?? false;
    final isInWatchlist = userContentState?.isInWatchlist ?? false;
    final isLoading = userContentState == null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: isLoading
              ? Icons.hourglass_empty
              : (isLiked ? Icons.favorite : Icons.favorite_border),
          label: 'Beğen',
          color: isLoading
              ? textColor.withOpacity(0.5)
              : (isLiked ? Colors.red : textColor),
          onTap: () {
            if (!isLoading) {
              ref.read(userContentProvider.notifier).toggleLike(contentId);
            }
          },
        ),
        _buildActionButton(
          icon: isLoading
              ? Icons.hourglass_empty
              : (isWatched ? Icons.visibility : Icons.visibility_outlined),
          label: 'İzledim',
          color: isLoading
              ? textColor.withOpacity(0.5)
              : (isWatched ? Colors.blue : textColor),
          onTap: () {
            if (!isLoading) {
              ref.read(userContentProvider.notifier).toggleWatch(contentId);
            }
          },
        ),
        _buildActionButton(
          icon: isLoading
              ? Icons.hourglass_empty
              : (isInWatchlist ? Icons.bookmark : Icons.bookmark_border),
          label: 'Listeme Ekle',
          color: isLoading
              ? textColor.withOpacity(0.5)
              : (isInWatchlist ? Colors.purple : textColor),
          onTap: () {
            if (!isLoading) {
              ref.read(userContentProvider.notifier).toggleWatchlist(contentId);
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentItem extends ConsumerWidget {
  final Comment comment;
  final Color textColor;
  final String contentId;

  const _CommentItem({
    required this.comment,
    required this.textColor,
    required this.contentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final currentUser = ref.watch(userProvider).user;
    final isCurrentUserComment = currentUser?.id == comment.userId;

    // User bilgisini kullan, yoksa userId'den oluştur
    final displayName =
        comment.user?.name ?? 'Kullanıcı ${comment.userId.substring(0, 4)}';
    final avatarUrl = comment.user?.avatarUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Avatar resmi varsa göster, yoksa ilk harfi göster
                  avatarUrl != null && avatarUrl.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(avatarUrl),
                          radius: 16,
                        )
                      : CircleAvatar(
                          backgroundColor: primaryColor.withOpacity(0.2),
                          radius: 16,
                          child: Text(
                            displayName.isNotEmpty
                                ? displayName[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  const SizedBox(width: 8),
                  Text(
                    displayName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              if (isCurrentUserComment)
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  color: Colors.red.shade300,
                  onPressed: () {
                    _showDeleteConfirmation(context, ref);
                  },
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            comment.text,
            style: TextStyle(color: textColor.withOpacity(0.9)),
          ),
          const SizedBox(height: 4),
          Text(
            _formatDate(comment.createdAt),
            style: TextStyle(
              fontSize: 12,
              color: textColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yorumu Sil'),
        content: const Text('Bu yorumu silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(commentProvider.notifier)
                  .deleteComment(contentId, comment.id);
              Navigator.of(context).pop();
            },
            child: const Text('Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

final commentProvider =
    StateNotifierProvider<CommentNotifier, List<Comment>?>((ref) {
  return CommentNotifier(ref);
});

class CommentNotifier extends StateNotifier<List<Comment>?> {
  final Ref _ref;
  bool isSubmitting = false;

  CommentNotifier(this._ref) : super(null);

  Future<void> loadComments(String contentId) async {
    final apiService = _ref.read(apiServiceProvider);
    try {
      // API'den yorumları yükle
      final response = await apiService.request('GET', '/comments/$contentId');
      final List<dynamic> commentsList = response.data;
      state = Comment.listFromApiResponse(commentsList);

      // Şimdilik yalnızca örnek için boş bir liste döndürüyorum
      // state = [];
    } catch (e) {
      print('Yorumlar yüklenirken hata: $e');
      state = [];
    }
  }

  Future<void> addComment(String contentId, String text) async {
    final _apiService = _ref.read(apiServiceProvider);
    try {
      isSubmitting = true;
      // Kullanıcı bilgilerini alın
      final user = _ref.read(userProvider).user;
      if (user == null) {
        // Kullanıcı giriş yapmamışsa
        throw Exception('Yorum yapmak için giriş yapmalısınız');
      }

      // API'ye yorum ekleme isteği gönder
      final response =
          await _apiService.request('POST', '/comments/$contentId', data: {
        'content_id': contentId,
        'text': text,
      });
      final newComment = Comment.fromApiResponse(response.data);

      // Şimdilik örnek olarak manuel yorum oluştur
      // final now = DateTime.now();
      // final newComment = Comment(
      //   id: now.millisecondsSinceEpoch.toString(),
      //   contentId: contentId,
      //   userId: user.uid,
      //   text: text,
      //   createdAt: now,
      //   updatedAt: now,
      //   user: CommentUser(
      //     id: user.uid,
      //     email: "user@example.com",
      //     name: user.displayName ?? "Kullanıcı",
      //     avatarUrl: null,
      //     gender: null,
      //     createdAt: now,
      //     updatedAt: now,
      //   ),
      // );

      // State'i güncelle
      if (state != null) {
        state = [newComment, ...state!];
      } else {
        state = [newComment];
      }

      isSubmitting = false;
    } catch (e) {
      print('Yorum eklenirken hata: $e');
      isSubmitting = false;
      // Hata mesajını kullanıcıya gösterebilirsiniz
    }
  }

  Future<void> deleteComment(String contentId, String commentId) async {
    final _apiService = _ref.read(apiServiceProvider);
    try {
      // API'den yorumu sil
      await _apiService.request('DELETE', '/comments/$commentId');

      // Başarılı olduktan sonra state'i güncelleyin
      if (state != null) {
        state = state!.where((comment) => comment.id != commentId).toList();
      }
    } catch (e) {
      print('Yorum silinirken hata: $e');
      // Hata mesajını kullanıcıya gösterebilirsiniz
    }
  }
}
