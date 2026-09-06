import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatarUrl,
    required this.gender,
    this.radius = 20,
  });
  final String? avatarUrl;
  final int gender;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final fallback = Icon(
      Icons.person,
      size: radius * 1.2,
      color: Colors.blueGrey,
    );
    final url = avatarUrl;
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      child: url == null || url.isEmpty
          ? fallback
          : ClipOval(
              child: Image.network(
                url,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallback,
              ),
            ),
    );
  }
}
