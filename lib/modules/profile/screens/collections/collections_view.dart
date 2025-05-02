import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/models/collection.dart';
import 'collection_provider.dart';
import 'content_list_view.dart';

class CollectionsView extends ConsumerStatefulWidget {
  const CollectionsView({Key? key}) : super(key: key);

  @override
  ConsumerState<CollectionsView> createState() => _CollectionsViewState();
}

class _CollectionsViewState extends ConsumerState<CollectionsView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _newCollectionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(userCollectionsProvider.notifier).loadCollections();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _newCollectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collectionsState = ref.watch(userCollectionsProvider);

    // Tema renklerini doğrudan almak:
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Koleksiyonlarım',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: backgroundColor,
        onRefresh: () async {
          await ref
              .read(userCollectionsProvider.notifier)
              .loadCollections(refresh: true);
        },
        child: collectionsState.when(
          data: (collections) {
            if (collections.isEmpty) {
              return _buildEmptyView(textColor, primaryColor);
            }

            return ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                return _buildCollectionCard(
                    collections[index], textColor, primaryColor);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(
              'Hata: $error',
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () =>
            _showCreateCollectionDialog(context, textColor, primaryColor),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyView(Color textColor, Color primaryColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            color: textColor.withOpacity(0.5),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz koleksiyonunuz yok',
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'İçerikleri gruplandırmak için koleksiyonlar oluşturabilirsiniz',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Koleksiyon Oluştur',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () =>
                _showCreateCollectionDialog(context, textColor, primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionCard(
      Collection collection, Color textColor, Color primaryColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContentListView(
                title: collection.title ?? '',
                source: ContentSource.collection,
                collectionId: collection.id,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.folder,
                    color: primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      collection.title ?? '',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: primaryColor.withOpacity(0.7),
                      size: 20,
                    ),
                    onPressed: () => _showEditCollectionDialog(
                      context,
                      collection,
                      textColor,
                      primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.withOpacity(0.7),
                      size: 20,
                    ),
                    onPressed: () => _showDeleteConfirmationDialog(
                      context,
                      collection,
                      textColor,
                      primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    collection.isPublic ?? false
                        ? Icons.public
                        : Icons.lock_outline,
                    color: textColor.withOpacity(0.5),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    collection.isPublic ?? false ? 'Herkese Açık' : 'Özel',
                    style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${collection.contentIds?.length ?? 0} içerik',
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateCollectionDialog(
      BuildContext context, Color textColor, Color primaryColor) {
    _newCollectionController.clear();
    bool isPublic = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Yeni Koleksiyon',
                style: TextStyle(color: textColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _newCollectionController,
                    decoration: InputDecoration(
                      labelText: 'Koleksiyon Adı',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: isPublic,
                        onChanged: (value) {
                          setState(() {
                            isPublic = value ?? false;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                      Text(
                        'Herkese Açık',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text(
                    'İptal',
                    style: TextStyle(color: textColor.withOpacity(0.7)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text('Oluştur',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    final title = _newCollectionController.text.trim();
                    if (title.isNotEmpty) {
                      final notifier =
                          ref.read(userCollectionsProvider.notifier);
                      notifier
                          .createCollection(
                        title: title,
                        isPublic: isPublic,
                      )
                          .then((_) {
                        Navigator.of(context).pop();
                      }).catchError((error) {
                        if (error.toString().contains(
                            'Bu başlıkta bir koleksiyon zaten mevcut')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Bu isimde bir koleksiyon zaten mevcut.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditCollectionDialog(
    BuildContext context,
    Collection collection,
    Color textColor,
    Color primaryColor,
  ) {
    final TextEditingController titleController =
        TextEditingController(text: collection.title);
    bool isPublic = collection.isPublic ?? false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Koleksiyonu Düzenle',
                style: TextStyle(color: textColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Koleksiyon Adı',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: isPublic,
                        onChanged: (value) {
                          setState(() {
                            isPublic = value ?? false;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                      Text(
                        'Herkese Açık',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text(
                    'İptal',
                    style: TextStyle(color: textColor.withOpacity(0.7)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text('Kaydet',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      ref
                          .read(userCollectionsProvider.notifier)
                          .updateCollection(
                            collectionId: collection.id ?? '',
                            title: title,
                            isPublic: isPublic,
                          );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    Collection collection,
    Color textColor,
    Color primaryColor,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Koleksiyonu Sil',
            style: TextStyle(color: textColor),
          ),
          content: Text(
            '"${collection.title}" koleksiyonunu silmek istediğinize emin misiniz?',
            style: TextStyle(color: textColor.withOpacity(0.7)),
          ),
          actions: [
            TextButton(
              child: Text(
                'İptal',
                style: TextStyle(color: textColor.withOpacity(0.7)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Sil', style: TextStyle(color: Colors.white)),
              onPressed: () {
                ref
                    .read(userCollectionsProvider.notifier)
                    .deleteCollection(collection.id ?? '');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
