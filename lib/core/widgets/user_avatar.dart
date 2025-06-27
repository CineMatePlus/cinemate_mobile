import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final int gender;
  final double radius;

  const UserAvatar({
    super.key,
    required this.avatarUrl,
    required this.gender,
    this.radius = 20,
  });

  ImageProvider _getAvatarImage() {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    } else {
      switch (gender) {
        case 0: // Female
          return const AssetImage(
              'lib/core/constants/assets/images/woman_icon.png');
        case 1: // Male
          return const AssetImage(
              'lib/core/constants/assets/images/man_icon.png');
        default: // Other or unspecified
          // Returning a transparent image and using the child icon instead.
          // This avoids AssetImage trying to load a null/empty path.
          return const AssetImage(
              'lib/core/constants/assets/images/transparent.png'); // You need a 1x1 transparent png
      }
    }
  }

  Widget? _getAvatarChild() {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return null;
    }
    if (gender == 2) {
      return Icon(Icons.person, size: radius);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: _getAvatarImage(),
      backgroundColor: Colors.grey.shade200,
      child: _getAvatarChild(),
    );
  }
}
