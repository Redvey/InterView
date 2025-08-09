import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import '../model/onboarding_data.dart';

class OnboardingConstants {
  static List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "Welcome to Interview Ace",
      description: "Your personal interview coach that helps you practice, improve, and land your dream job.",
    ),
    OnboardingData(
      title: "Practice Mock Interviews",
      description: "Get realistic interview practice with AI-powered feedback and suggestions for improvement.",
    ),
    OnboardingData(
      title: "Build a Perfect Resume",
      description: "Create ATS-friendly resumes with our smart builder and get professional reviews.",
    ),
    OnboardingData(
      title: "Track Your Progress",
      description: "Monitor your improvement over time and identify areas that need more attention.",
    ),
    OnboardingData(
      title: "Track Your Progress",
      description: "Monitor your improvement over time and identify areas that need more attention.",
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