import 'package:flutter/material.dart';
import 'package:interview/features/home/widgets/star_rating.dart';

import '../../../app/themes/text_styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/strings.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      child: Container(
        height: AppSizes.adCard,
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.lg),
        decoration: BoxDecoration(
          color: AppColors.blackLight,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.purpleOverlay,
              blurRadius: AppSizes.welcomeBlur,
              offset:  Offset(AppSizes.zero, AppSizes.shadowOffsetY),
              spreadRadius: AppSizes.welcomeSpread,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Glow Bar
            Container(
              width: AppSizes.glowW,
              height: AppSizes.glowH,
              decoration: BoxDecoration(
                color: AppColors.otherForm,
                borderRadius: BorderRadius.circular(AppSizes.glowB),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple,
                    blurRadius: AppSizes.glowBlur,
                    offset: Offset(AppSizes.zero, AppSizes.shadowOffsetY),
                    spreadRadius: AppSizes.glowSpread,
                  ),
                ],
              ),
            ),

            Text(AppStrings.finalSteps, style: AppTextStyles.welcomeCardFinal),

            Text(
              AppStrings.crackIt,
              style: AppTextStyles.crackIt,
              textAlign: TextAlign.center,
            ),

            ///To Do
            buildStarRating(rating: 4.5),
          ],
        ),
      ),
    );
  }
}
