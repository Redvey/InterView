import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';


class AvatarData {
  final IconData icon;
  final Color background;

  AvatarData({required this.icon, required this.background});
}

final List<AvatarData> avatarList = [
  AvatarData(icon: Icons.sunny_snowing, background: Colors.orange.shade100),
  AvatarData(icon: Icons.star_outline, background: AppColors.textRedBg),
  AvatarData(icon: Icons.pets_outlined, background: Colors.green.shade100),
  AvatarData(icon: Icons.sports_soccer_outlined, background: Colors.blue.shade100),
];
