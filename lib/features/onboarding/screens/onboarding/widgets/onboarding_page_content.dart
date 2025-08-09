import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../app/themes/fonts.dart';
import '../model/onboarding_data.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPageContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.lg,
        vertical: context.lgV,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Space for the animation
          Text(
            data.title,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: context.fontSizeMd,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.spaceBtwItemsH), // Changed from 24
          Text(
            data.description,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: context.fontSizeSx, // Changed from 16
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}