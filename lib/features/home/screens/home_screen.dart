import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/themes/text_styles.dart';
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
                    color: AppColors.blackLight,
                  ),
                  child: Center(
                    child: Text(
                      "< crack the interview />",
                      style: TextStyle(color: AppColors.textGreen),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems),

                //resume builder
                GestureDetector(
                  onTap: () => context.push('/form'),
                  child: FeatureContainer(
                    gradient: AppColors.resumeBuilderGradient,
                    title: AppStrings.buildYourResumeTitle,
                    subTitle: AppStrings.buildYourResumeSubtitle,
                    color: AppColors.textRedBg,
                    colorBg: AppColors.textRed,
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace),

                //resume review
                GestureDetector(
                  onTap: () => context.push('/review'),
                  child: FeatureContainer(
                    gradient: AppColors.reviewGradient,
                    title: AppStrings.resumeReviewTitle,
                    subTitle: AppStrings.resumeReviewSubtitle,
                    color: AppColors.textBlueBg,
                    colorBg: AppColors.textBlue,
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace),

                //flashcard
                GestureDetector(
                  onTap: () => context.push('/unfinished'),
                  child: FeatureContainer(
                    gradient: AppColors.flashcardGradient,
                    title: AppStrings.flashcardPracticeTitle,
                    subTitle: AppStrings.flashcardPracticeSubtitle,
                    color: AppColors.textGreenBg,
                    colorBg: AppColors.textGreen,
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace),
                GestureDetector(
                  onTap: () => context.push('/unfinished'),
                  child: FeatureContainer(
                    gradient: AppColors.interviewGradient,
                    title: AppStrings.mockInterviewTitle,
                    subTitle: AppStrings.mockInterviewSubtitle,
                    color: AppColors.textYellowBg,
                    colorBg: AppColors.textYellow,
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace),
                GestureDetector(
                  onTap: () => context.push('/review'),
                  child: FeatureContainer(
                    gradient: AppColors.coldMailGradient,
                    title: AppStrings.coldMailTitle,
                    subTitle: AppStrings.coldMailSubtitle,
                    color: AppColors.textPurpleBg,
                    colorBg: AppColors.textPurple,
                  ),
                ),
                SizedBox(height: AppSizes.defaultSpace),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(radius: 5,),
                    CircleAvatar(radius: 5,),
                    CircleAvatar(radius: 5,),
                  ],
                ),
                SizedBox(height: AppSizes.defaultSpace),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusLg,
                    ),
                    gradient: AppColors.backgroundGradient,
                  ),
                  child: Center(
                    child: Text("GOOGLE AD", style: AppTextStyles.welcome),
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
