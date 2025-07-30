import 'package:flutter/material.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

class QuizCompletionDialog extends StatelessWidget {
  final String topic;
  final int done;
  final int inReview;
  final VoidCallback onBackToTopics;
  final VoidCallback onRestartQuiz;

  const QuizCompletionDialog({
    super.key,
    required this.topic,
    required this.done,
    required this.inReview,
    required this.onBackToTopics,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(context.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular( context.borderRadiusLg),
        child: Container(
          padding: EdgeInsets.all(context.lg),
          decoration: BoxDecoration(
            image: DecorationImage(image:AssetImage(AppImage.temp1),fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(context.borderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withAlpha(1075),
                blurRadius: context.welcomeBlur,
                offset: Offset(0, context.shadowOffsetY),
                spreadRadius: context.welcomeSpread,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: context.glowW,
                  height: context.glowH,
                  decoration: BoxDecoration(
                    color: AppColors.textGreen,
                    borderRadius: BorderRadius.circular(context.glowH / 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.backgroundGreen,
                        blurRadius: context.glowBlur,
                        offset: Offset(0, context.shadowOffsetY),
                        spreadRadius: context.glowSpread,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.spaceBtwItems),
              Text(
                AppStrings.quizCompletedMessage(topic),
                style: const TextStyle(color: AppColors.backgroundWhite),
              ),
              SizedBox(height: context.defaultSpace),
              _buildStatsRow(),
              SizedBox(height: context.spaceBtwFields),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onBackToTopics,
                    child: const Text(AppStrings.backToTopics,style: TextStyle(color: AppColors.textGreen),),
                  ),
                  ElevatedButton(
                    onPressed: onRestartQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textGreen,
                    ),
                    child: const Text(AppStrings.restartQuiz,style: TextStyle(color:AppColors.blackLight),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '$done',
              style: const TextStyle(
                color: AppColors.textGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              AppStrings.known,
              style: TextStyle(color: AppColors.backgroundWhite,fontFamily: 'Poppins'),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '$inReview',
              style: const TextStyle(
                color: AppColors.backgroundOrange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              AppStrings.toReview,
              style: TextStyle(color: AppColors.backgroundWhite),
            ),
          ],
        ),
      ],
    );
  }
}
