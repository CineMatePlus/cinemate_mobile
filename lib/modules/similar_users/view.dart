import 'package:cinemate_mobile/core/constants/colors.dart';
import 'package:cinemate_mobile/core/constants/text_styles.dart';
import 'package:cinemate_mobile/core/widgets/user_avatar.dart';
import 'package:cinemate_mobile/modules/similar_users/models/similar_user.dart';
import 'package:cinemate_mobile/modules/similar_users/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return _SimilarUserCard(user: user);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SimilarUserCard extends StatelessWidget {
  const _SimilarUserCard({required this.user});

  final SimilarUser user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserAvatar(
                    avatarUrl: user.avatarUrl,
                    gender: user.gender,
                    radius: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: AppTextStyles.heading5,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    '@${user.email.split('@').first}',
                    style:
                        AppTextStyles.bodyMedium.withColor(AppColors.textGrey),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderGrey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 5.0,
                percent: user.similarity,
                center: UserAvatar(
                  avatarUrl: user.avatarUrl,
                  gender: user.gender,
                  radius: 35,
                ),
                progressColor: AppColors.primary,
                backgroundColor: AppColors.borderGrey.withOpacity(0.3),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 12),
              Text(
                user.name,
                style: AppTextStyles.bodyLarge.withWeight(FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${(user.similarity * 100).toStringAsFixed(1)}% Match',
                style: AppTextStyles.bodyMedium.withColor(AppColors.textGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
