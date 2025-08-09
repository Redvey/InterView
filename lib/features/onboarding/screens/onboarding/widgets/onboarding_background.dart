import 'package:flutter/material.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'constants_onboarding.dart';

class OnboardingBackground extends StatelessWidget {
  final double currentPage;

  const OnboardingBackground({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Background Image - slides across 4 pages
        Positioned(
          left: -(currentPage * screenWidth * 0.60), // Reduced movement per page
          top: screenHeight / 12,
          child: SizedBox(
            width: screenWidth * 3, // 4x screen width
            height: screenHeight,
            child: Image.asset(
              AppImage.paths9,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient overlay to ensure text readability
        Container(
          decoration: BoxDecoration(
            gradient: _buildGradientOverlay(),
          ),
        ),
      ],
    );
  }

  LinearGradient? _buildGradientOverlay() {
    final currentGradient = OnboardingConstants.pageGradients[
    currentPage.round().clamp(0, OnboardingConstants.pageGradients.length - 1)
    ];

    if (currentGradient.colors.length > 1) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          currentGradient.colors.first.withAlpha(200),
          currentGradient.colors.last.withAlpha(200),
        ],
      );
    }
    return null;
  }
}