import 'dart:io';
import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class ProfileImageSelector extends StatelessWidget {
  final File? profileImageFile;
  final String? profileImagePath;
  final List<IconData> avatarIcons;
  final IconData? selectedAvatarIcon;
  final Color? selectedAvatarBg;
  final VoidCallback onChooseImage;

  const ProfileImageSelector({
    super.key,
    required this.profileImageFile,
    required this.profileImagePath,
    required this.avatarIcons,
    required this.onChooseImage,
    this.selectedAvatarIcon,
    this.selectedAvatarBg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChooseImage,
      child: Container(
        width: context.lottieWidth * 0.5,
        height: context.lottieHeight * 0.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey300,
          border: Border.all(
            color: AppColors.searchFill,
            width: context.borderWidthThin,
          ),
        ),
        child: _buildProfileContent(),
      ),
    );
  }

  Widget _buildProfileContent() {
    if (profileImageFile != null) {
      return ClipOval(
        child: Image.file(profileImageFile!, fit: BoxFit.cover),
      );
    }
    if (selectedAvatarIcon != null) {
      return CircleAvatar(
        backgroundColor: selectedAvatarBg ?? AppColors.textBlueBg,
        child: Icon(selectedAvatarIcon, size: 40, color: AppColors.black87),
      );
    }
    if (profileImagePath != null &&
        !avatarIcons.any((icon) => icon.codePoint.toString() == profileImagePath)) {
      return ClipOval(
        child: Image.asset(profileImagePath!, fit: BoxFit.cover),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.textGrey),
        const SizedBox(height: 4),
        Text('Add Photo', style: const TextStyle(color: AppColors.textGrey)),
      ],
    );
  }
}
