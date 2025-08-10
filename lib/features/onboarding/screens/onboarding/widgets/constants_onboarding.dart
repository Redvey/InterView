import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import '../model/onboarding_data.dart';

class OnboardingConstants {
  static List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "Welcome to Interview App",
      description: "Build,improve and land your dream job.",
    ),
    OnboardingData(
      title: "Resume Review",
      description: "Get job matching percentage",
    ),
    OnboardingData(
      title: "Practice Flash Cards",
      description: "Learn and practice interview topics with flash cards",
    ),
    OnboardingData(
      title: "Take Mock Interview",
      description: "Take Live Interview to track progress, gain more experience and be interview ready",
    ),
    OnboardingData(
      title: "Send Cold Mail",
      description: "Send refined Mails to recruiters using mail templates",
    ),
  ];

  // Different gradients for each page
  static const List<Gradient> pageGradients = [
    AppColors.onboard1,
    AppColors.onboard2,
    AppColors.onboard3,
    AppColors.onboard4,
    AppColors.onboard5,

  ];
}