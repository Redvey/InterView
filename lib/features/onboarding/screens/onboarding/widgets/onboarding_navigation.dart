import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart'; // Import the extension
import 'constants_onboarding.dart';

class OnboardingBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNextPressed;

  const OnboardingBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentIndex == totalPages - 1;

    return Padding(
      padding: EdgeInsets.all(context.lg), // Changed from 32
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circle (decorative)
          Container(
            width: context.circularButtonSize * 2, // Approximating 120
            height: context.circularButtonSize * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.grey300,
                width: context.borderWidthDefault, // Changed from 2
              ),
            ),
          ),

          // Inner circle (decorative)
          Container(
            width: context.circularButtonSize, // Approximating 80
            height: context.circularButtonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white12,
                width: context.borderWidthThin, // Changed from 1
              ),
            ),
            child: Container(
              width: context.mainActionButtonSize, // Approximating 60
              height: context.mainActionButtonSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: onNextPressed,
                icon: Icon(
                  isLastPage
                      ? Icons.check_rounded
                      : Icons.arrow_forward_ios_rounded,
                  color: OnboardingConstants.pageGradients[currentIndex].colors.first,
                  size: context.iconSizeSm, // Changed from 24
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}