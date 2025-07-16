import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/home/widgets/welcome_message.dart';

import '../../../core/utils/helper_functions.dart';
import '../widgets/welcome_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppSizes.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeMessage(),
                SizedBox(height: AppSizes.spaceBtwSections),
                const WelcomeCard(),
                SizedBox(height: AppSizes.defaultSpace),

                /// Resume Builder
                featureListItem(
                  context: context,
                  onTap: () => context.push('/form'),
                  gradient: AppColors.resumeBuilderGradient,
                  title: AppStrings.buildYourResumeTitle,
                  subTitle: AppStrings.buildYourResumeSubtitle,
                  color: AppColors.textRedBg,
                  colorBg: AppColors.textRed,
                ),

                /// Resume Review
                featureListItem(
                  context: context,
                  onTap: () => context.push('/review'),
                  gradient: AppColors.reviewGradient,
                  title: AppStrings.resumeReviewTitle,
                  subTitle: AppStrings.resumeReviewSubtitle,
                  color: AppColors.textBlueBg,
                  colorBg: AppColors.textBlue,
                ),

                /// Flashcard Practice
                featureListItem(
                  context: context,
                  onTap: () => context.push('/flash-card'),
                  gradient: AppColors.flashcardGradient,
                  title: AppStrings.flashcardPracticeTitle,
                  subTitle: AppStrings.flashcardPracticeSubtitle,
                  color: AppColors.textGreenBg,
                  colorBg: AppColors.textGreen,
                ),

                /// Mock Interview
                featureListItem(
                  context: context,
                  onTap: () => context.push('/interview'),
                  gradient: AppColors.interviewGradient,
                  title: AppStrings.mockInterviewTitle,
                  subTitle: AppStrings.mockInterviewSubtitle,
                  color: AppColors.textYellowBg,
                  colorBg: AppColors.textYellow,
                ),

                /// Cold Mail Generator
                featureListItem(
                  context: context,
                  onTap: () => context.push('/interview'),
                  gradient: AppColors.coldMailGradient,
                  title: AppStrings.coldMailTitle,
                  subTitle: AppStrings.coldMailSubtitle,
                  color: AppColors.textPurpleBg,
                  colorBg: AppColors.textPurple,
                ),

                /// Ads Section
                Divider(thickness: AppSizes.dividerHeight),
                SizedBox(height: AppSizes.defaultSpace),

                Container(
                  height: AppSizes.adCard,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
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
