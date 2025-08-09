import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart'; // Import the extension
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingTopBar extends StatelessWidget {
  final PageController pageController;
  final int onboardingPagesCount;
  final VoidCallback onSkip;

  const OnboardingTopBar({
    super.key,
    required this.pageController,
    required this.onboardingPagesCount,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.defaultSpace, // Changed from 20
        vertical: context.mdV, // Changed from 16
      ),
      child: Column(
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: onboardingPagesCount,
            onDotClicked: (index) => pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
            effect: ExpandingDotsEffect(
              dotHeight: context.sm,
              // Changed from 8
              dotWidth: context.sm,
              // Changed from 8
              expansionFactor: 4,
              spacing: context.defaultSpace,
              // Changed from 12
              radius: context.xs,
              // Changed from 4
              dotColor: AppColors.grey300,
              activeDotColor: Colors.white,
              paintStyle: PaintingStyle.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: context.zero),

              // Skip button on the right
              TextButton(
                onPressed: onSkip,
                child: Text(
                  AppStrings.skip,
                  style: context.buttonWhiteTextStyle
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
