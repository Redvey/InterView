import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import 'animated_wrapper.dart';
import '../animation/home_animation_manager.dart';
import 'feature_list_item.dart';

class AnimatedFeatureList extends StatelessWidget {
  final HomeAnimationManager animationManager;
  final int startIndex;

  const AnimatedFeatureList({
    super.key,
    required this.animationManager,
    required this.startIndex,
  });

  @override
  Widget build(BuildContext context) {
    final features = _getFeaturesList(context);

    return Column(
      children: List.generate(features.length, (index) {
        final animationIndex = startIndex + index;
        return AnimatedContentWrapper(
          fadeAnimation: animationManager.fadeAnimations[animationIndex],
          slideAnimation: animationManager.slideAnimations[animationIndex],
          child: features[index],
        );
      }),
    );
  }

  List<Widget> _getFeaturesList(BuildContext context) {
    return [
      FeatureListItem(
        onTap: () => context.push('/form'),
        gradient: AppColors.resumeBuilderGradient,
        title: AppStrings.buildYourResumeTitle,
        subTitle: AppStrings.buildYourResumeSubtitle,
        color: AppColors.textRedBg,
        colorBg: AppColors.textRed,
      ),
      FeatureListItem(
        onTap: () => context.push('/review'),
        gradient: AppColors.reviewGradient,
        title: AppStrings.resumeReviewTitle,
        subTitle: AppStrings.resumeReviewSubtitle,
        color: AppColors.textBlueBg,
        colorBg: AppColors.textBlue,
      ),
      FeatureListItem(
        onTap: () => context.push('/flash-card'),
        gradient: AppColors.flashcardGradient,
        title: AppStrings.flashcardPracticeTitle,
        subTitle: AppStrings.flashcardPracticeSubtitle,
        color: AppColors.textGreenBg,
        colorBg: AppColors.textGreen,
      ),
      FeatureListItem(
        onTap: () => context.push('/interview'),
        gradient: AppColors.interviewGradient,
        title: AppStrings.mockInterviewTitle,
        subTitle: AppStrings.mockInterviewSubtitle,
        color: AppColors.textYellowBg,
        colorBg: AppColors.textYellow,
      ),
      FeatureListItem(
        onTap: () => context.push('/interview'),
        gradient: AppColors.coldMailGradient,
        title: AppStrings.coldMailTitle,
        subTitle: AppStrings.coldMailSubtitle,
        color: AppColors.textPurpleBg,
        colorBg: AppColors.textPurple,
      ),
    ];
  }
}