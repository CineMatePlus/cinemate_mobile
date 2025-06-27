import 'package:cinemate_mobile/core/constants/text_styles.dart';
import 'package:cinemate_mobile/modules/similar_users/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimilarUsersView extends ConsumerWidget {
  const SimilarUsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarUsersAsync = ref.watch(similarUsersProvider);

    return Scaffold(
      body: similarUsersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Text('No similar users found.'),
            );
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: user.avatarUrl != null
                      ? NetworkImage(user.avatarUrl!)
                      : null,
                  child:
                      user.avatarUrl == null ? const Icon(Icons.person) : null,
                ),
                title: Text(user.name),
                subtitle: Text(
                    'Similarity: ${(user.similarity * 100).toStringAsFixed(2)}%'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
