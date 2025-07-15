import 'package:flutter/material.dart';

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
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.blackLight,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withAlpha(107),
              blurRadius: 40,
              offset: const Offset(0, -10),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Glow Bar
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.otherForm,
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple,
                    blurRadius: 100,
                    offset: const Offset(0, -10),
                    spreadRadius: 25,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Final Steps Toward Your Goal",
              style: TextStyle(
                color: AppColors.backgroundYellow,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.crackIt,
              style: TextStyle(color: AppColors.textGreen),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            buildStarRating(
              rating: 4.5,
              gradient: AppColors.starGradient
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStarRating({
    required double rating,
    double iconSize = 28,
    int maxStars = 5,
    Gradient gradient = AppColors.backgroundGradient,
  }) {
    final List<Widget> stars = [];

    for (int i = 0; i < maxStars; i++) {
      stars.add(
        ShaderMask(
          shaderCallback: (bounds) => gradient.createShader(bounds),
          child: Icon(Icons.star_rounded, size: iconSize, color: Colors.white),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }
}