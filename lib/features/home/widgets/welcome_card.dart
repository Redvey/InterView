import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/home/widgets/star_rating.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular( context.borderRadiusLg),
      child: Container(
        height:  context.adCard,
        width: double.infinity,
        padding: EdgeInsets.all( context.lg),
        decoration: BoxDecoration(
          color: AppColors.blackLight,
          borderRadius: BorderRadius.circular( context.borderRadiusLg),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width:  context.glowW,
              height:  context.glowH,
              decoration: BoxDecoration(
                color: AppColors.otherForm,
                borderRadius: BorderRadius.circular( context.glowB),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple,
                    blurRadius:  context.glowBlur,
                    offset: Offset( context.zero,  context.shadowOffsetY),
                    spreadRadius:  context.glowSpread,
                  ),
                ],
              ),
            ),
            Text(AppStrings.finalSteps, style: context.welcomeCardFinalStyle),
            Text(AppStrings.crackIt, style: context.crackItStyle, textAlign: TextAlign.center),
            buildStarRating(context,rating: 4.5),
          ],
        ),
      ),
    );
  }
}

