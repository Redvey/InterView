import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/home/widgets/welcome_message.dart';

import '../../../core/utils/helper_functions.dart';
import '../widgets/welcome_card.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding:   context.screenPadding  ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeMessage(),
                SizedBox(height:   context.spaceBtwSections  ),
                const WelcomeCard(),
                SizedBox(height:   context.defaultSpaceH  ),

                featureListItem(
                  context: context,
                  onTap: () => context.push('/form'),
                  gradient: AppColors.resumeBuilderGradient,
                  title: AppStrings.buildYourResumeTitle,
                  subTitle: AppStrings.buildYourResumeSubtitle,
                  color: AppColors.textRedBg,
                  colorBg: AppColors.textRed,
                ),

                featureListItem(
                  context: context,
                  onTap: () => context.push('/review'),
                  gradient: AppColors.reviewGradient,
                  title: AppStrings.resumeReviewTitle,
                  subTitle: AppStrings.resumeReviewSubtitle,
                  color: AppColors.textBlueBg,
                  colorBg: AppColors.textBlue,
                ),

                featureListItem(
                  context: context,
                  onTap: () => context.push('/flash-card'),
                  gradient: AppColors.flashcardGradient,
                  title: AppStrings.flashcardPracticeTitle,
                  subTitle: AppStrings.flashcardPracticeSubtitle,
                  color: AppColors.textGreenBg,
                  colorBg: AppColors.textGreen,
                ),

                featureListItem(
                  context: context,
                  onTap: () => context.push('/interview'),
                  gradient: AppColors.interviewGradient,
                  title: AppStrings.mockInterviewTitle,
                  subTitle: AppStrings.mockInterviewSubtitle,
                  color: AppColors.textYellowBg,
                  colorBg: AppColors.textYellow,
                ),

                featureListItem(
                  context: context,
                  onTap: () => context.push('/interview'),
                  gradient: AppColors.coldMailGradient,
                  title: AppStrings.coldMailTitle,
                  subTitle: AppStrings.coldMailSubtitle,
                  color: AppColors.textPurpleBg,
                  colorBg: AppColors.textPurple,
                ),

                Divider(thickness:   context.dividerHeight  ),
                SizedBox(height:   context.defaultSpaceH  ),

                Container(
                  height:   context.adCard  ,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(  context.borderRadiusLg  ),
                    gradient: AppColors.backgroundGradient,
                  ),
                  child: Center(
                    child: Text(AppStrings.ad, style: context.welcomeStyle  ),
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
