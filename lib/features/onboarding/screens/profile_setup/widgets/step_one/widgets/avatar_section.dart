import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_one/utils/avatar_data.dart';

class AvatarSelector extends StatelessWidget {
  final List<AvatarData> avatars;
  final String? selectedPath;
  final Function(AvatarData) onSelectAvatar;

  const AvatarSelector({
    super.key,
    required this.avatars,
    required this.selectedPath,
    required this.onSelectAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: avatars.map((avatar) {
        final isSelected = selectedPath == avatar.icon.codePoint.toString();
        return GestureDetector(
          onTap: () => onSelectAvatar(avatar),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.searchFill : Colors.transparent,
                width: context.borderWidthThin,
              ),
            ),
            child: CircleAvatar(
              radius: context.iconSizeSm,
              backgroundColor: avatar.background,
              child: Icon(
                avatar.icon,
                color: AppColors.black87,
                size: context.iconSizeMD,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
