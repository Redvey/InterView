import 'package:flutter/material.dart';
import 'package:interview/core/constants/image_strings.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.radius = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(AppImage.temp),
      ),
    );
  }
}