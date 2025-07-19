
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

class FeatureData {
  final String route;
  final Gradient gradient;
  final String title;
  final String subTitle;
  final Color color;
  final Color colorBg;

  const FeatureData({
    required this.route,
    required this.gradient,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.colorBg,
  });

  static List<FeatureData> get allFeatures => [
    FeatureData(
      route: '/form',
      gradient: AppColors.resumeBuilderGradient,
      title: AppStrings.buildYourResumeTitle,
      subTitle: AppStrings.buildYourResumeSubtitle,
      color: AppColors.textRedBg,
      colorBg: AppColors.textRed,
    ),
    FeatureData(
      route: '/review',
      gradient: AppColors.reviewGradient,
      title: AppStrings.resumeReviewTitle,
      subTitle: AppStrings.resumeReviewSubtitle,
      color: AppColors.textBlueBg,
      colorBg: AppColors.textBlue,
    ),
    FeatureData(
      route: '/flash-card',
      gradient: AppColors.flashcardGradient,
      title: AppStrings.flashcardPracticeTitle,
      subTitle: AppStrings.flashcardPracticeSubtitle,
      color: AppColors.textGreenBg,
      colorBg: AppColors.textGreen,
    ),
    FeatureData(
      route: '/interview',
      gradient: AppColors.interviewGradient,
      title: AppStrings.mockInterviewTitle,
      subTitle: AppStrings.mockInterviewSubtitle,
      color: AppColors.textYellowBg,
      colorBg: AppColors.textYellow,
    ),
    FeatureData(
      route: '/interview',
      gradient: AppColors.coldMailGradient,
      title: AppStrings.coldMailTitle,
      subTitle: AppStrings.coldMailSubtitle,
      color: AppColors.textPurpleBg,
      colorBg: AppColors.textPurple,
    ),
  ];
}