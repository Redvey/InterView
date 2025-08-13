// profile_setup_progress.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

class ProfileSetupProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProfileSetupProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Step indicator text
        Text(
          'Step $currentStep of $totalSteps',
          style: context.bodyBoldStyle.copyWith(color: AppColors.blackLight),
        ),
        SizedBox(height: context.sm),

        // Progress bar
        Container(
          height: context.xs,
          decoration: BoxDecoration(
            color: AppColors.grey300,
            borderRadius: BorderRadius.circular(context.radiusXS),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: currentStep / totalSteps,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.progressBar,
                borderRadius: BorderRadius.circular(context.radiusXS),
              ),
            ),
          ),
        ),

        SizedBox(height: context.md),

      ],
    );
  }
}