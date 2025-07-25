import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/strings.dart';

class FinishInterview extends StatelessWidget {
  const FinishInterview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.specialGradient),
        child: Padding(
          padding: context.defaultPadding,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ Animation
                  SizedBox(
                    height: context.lottieHeight,
                    width: context.lottieWidth,
                    child: Lottie.asset(AppAnimations.complete),
                  ),

                  context.verticalSpaceMedium,

                  // ✅ Title
                  Text(
                    AppStrings.mockInterviewCompletedTitle,
                    textAlign: TextAlign.center,
                    style: context.headingStyle(
                      color: AppColors.backgroundBlue,
                    ),
                  ),

                  // ✅ Subtitle
                  Text(
                    AppStrings.mockInterviewCompletedMessage,
                    textAlign: TextAlign.center,
                    style: context.subheadingStyle(
                      color: AppColors.backgroundSky,
                    ),
                  ),

                  context.verticalSpaceMedium,

                  // ✅ Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Back button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bottomBlack,
                          foregroundColor: AppColors.backgroundWhite,
                          textStyle: AppTextStyles.buttonSmall(context),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.defaultSpace,
                            vertical: context.spaceLess,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.buttonRadius,
                            ),
                          ),
                        ),
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: context.navIconSizeUnselected,
                        ),
                        label: Text(AppStrings.back),
                      ),

                      context.horizontalSpaceMedium,

                      // Interview report button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bottomBlack,
                          foregroundColor: AppColors.backgroundWhite,
                          textStyle: AppTextStyles.buttonSmall(context),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.defaultSpace,
                            vertical: context.spaceLess,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.buttonRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Interview report action
                        },
                        icon: Icon(
                          Icons.interests_rounded,
                          size: context.navIconSizeUnselected,
                        ),
                        label: Text(AppStrings.interviewReport),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
