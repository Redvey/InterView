import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

class AuthBranding extends StatelessWidget {
  const AuthBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: context.buttonWidth,
          height: context.buttonWidth,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryLight, AppColors.blue600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(context.radiusXL),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(70),
                blurRadius: context.radiusLG,
                offset: Offset(0, context.spaceLess),
              ),
            ],
          ),
          child: Icon(
            Icons.psychology,
            size: context.xl,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: context.lg),
        Text('Interview Ace', style: context.headingStyle(color: AppColors.black87)),
        SizedBox(height: context.spaceLessH),
        Text(
          'Master Your Interviews & Land Your Dream Job',
          style: context.subheadingStyle(color: AppColors.textGrey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}