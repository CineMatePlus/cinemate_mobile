import 'package:flutter/material.dart';
import '../../../core/constants/theme_constants.dart';
import '../models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ThemeConstants.defaultPadding),
      decoration: BoxDecoration(
        color: ThemeConstants.secondaryColor,
        borderRadius: BorderRadius.circular(ThemeConstants.defaultRadius),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.avatarUrl ?? ''),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(
                    color: ThemeConstants.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: ThemeConstants.subtitleColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Show edit profile dialog
            },
            icon: const Icon(
              Icons.edit,
              color: ThemeConstants.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
