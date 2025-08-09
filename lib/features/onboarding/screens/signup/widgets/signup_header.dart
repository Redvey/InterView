import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: context.xxxl,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: context.sm),
        Text(
          'Join Interview Ace and start your journey to success',
          style: TextStyle(
            fontSize: context.fontSizeSx,
            color: AppColors.textGrey,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}