import 'package:cinemate_mobile/modules/collections/screens/collection_detail/view.dart';
import 'package:cinemate_mobile/modules/collections/screens/collections_list/state.dart';
import 'package:cinemate_mobile/modules/collections/widgets/collection_card.dart';
import 'package:cinemate_mobile/modules/collections/widgets/create_collection_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionsListView extends ConsumerWidget {
  const CollectionsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collections'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      body: collectionsAsync.when(
        data: (screenState) {
          final collections = screenState.collections;
          if (collections.isEmpty) {
            return const Center(child: Text('No collections yet. Create one!'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            padding: const EdgeInsets.all(16.0),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final collection = collections[index];
              return CollectionCard(
                collection: collection,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CollectionDetailView(collectionId: collection.id),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Failed to load collections: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CreateCollectionModal(),
          );
        },
        backgroundColor: const Color(0xFF0F3460),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
