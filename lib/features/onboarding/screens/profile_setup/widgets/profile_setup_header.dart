import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../core/constants/colors.dart';

class ProfileSetupHeader extends StatelessWidget {
  const ProfileSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Complete Your Profile',
          style: context.headingStyle(color: AppColors.black87),
        ),
        SizedBox(height: context.sm),
        Text(
          'Tell us a bit about yourself to personalize your experience',
          style: context.subheadingStyle(color: AppColors.textGrey),
        ),
      ],
    );
  }
}