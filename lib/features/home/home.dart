import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/home/widgets/feature_container.dart';
import 'package:interview/features/home/widgets/welcome_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            top: AppSizes.xl,
            left: AppSizes.lg,
            right: AppSizes.lg,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeMessage(),
                SizedBox(height: AppSizes.spaceBtwSections),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusLg,
                    ),
                    gradient: AppColors.backgroundGradient,
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems),
                GestureDetector(
                  onTap: () => context.push('/form'),
                  child: FeatureContainer(
                    gradient: AppColors.resumeBuilderGradient,
                    title: AppStrings.buildYourResumeTitle,
                    subTitle: AppStrings.buildYourResumeSubtitle,
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace),
                FeatureContainer(
                  gradient: AppColors.reviewGradient,
                  title: AppStrings.resumeReviewTitle,
                  subTitle: AppStrings.resumeReviewSubtitle,
                ),
                SizedBox(height: AppSizes.defaultSpace),
                FeatureContainer(
                  gradient: AppColors.flashcardGradient,
                  title: AppStrings.flashcardPracticeTitle,
                  subTitle: AppStrings.flashcardPracticeSubtitle,
                ),
                SizedBox(height: AppSizes.defaultSpace),
                FeatureContainer(
                  gradient: AppColors.interviewGradient,
                  title: AppStrings.mockInterviewTitle,
                  subTitle: AppStrings.mockInterviewSubtitle,
                ),
                SizedBox(height: AppSizes.defaultSpace),
                FeatureContainer(
                  gradient: AppColors.coldMailGradient,
                  title: AppStrings.mockInterviewTitle,
                  subTitle: AppStrings.mockInterviewSubtitle,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusLg,
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
