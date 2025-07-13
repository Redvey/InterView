import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/profile-animation'),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(
          'assets/templates/template1.jpeg',
        ),
      ),
    );
  }
}
