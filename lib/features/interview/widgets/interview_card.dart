import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/interview/widgets/difficulty_chip.dart';

import '../models/difficulty_level.dart';
import '../models/interview_item.dart';



class InterviewCard extends StatelessWidget {
  final InterviewItem interviewItem;
  final VoidCallback? onTap;

  const InterviewCard({super.key, required this.interviewItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: context.spaceBtwItemsH),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightBlue,
        borderRadius: BorderRadius.circular(context.borderRadiusLx),
        boxShadow: [
          BoxShadow(
            color: AppColors.backgroundYellow.withAlpha(204),
            blurRadius: context.defaultSpace,
            offset: Offset(0.0, context.shadowOffsetY),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.borderRadiusLx),
        child: Padding(
          padding: context.defaultPadding,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(context.borderRadiusMd),
                          child: Image.asset(
                            AppImage.temp3,
                            width: context.xl,
                            height: context.xl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: context.xl,
                                height: context.xl,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundWhite,
                                  borderRadius: BorderRadius.circular(context.borderRadiusMd),
                                ),
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                  size: context.closeButtonIconSize,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: context.spaceLess),
                        Expanded(
                          child: Text(
                            interviewItem.jobTitle,
                            style: AppTextStyles.interviewTemplateJob(context),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.spaceLessH),
                    Text(
                      interviewItem.jobDescription,
                      style: AppTextStyles.interviewTemplateJobDescription(context),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.md),
                    Text(
                      AppStrings.topic,
                      style: AppTextStyles.featureTitle(context),
                    ),
                    SizedBox(height: context.spaceLessH),
                    Wrap(
                      spacing: context.starSpacing,
                      runSpacing: context.spaceLessH,
                      children: interviewItem.topics.map((topic) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spaceLess,
                            vertical: context.spaceLessH / 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.chipBackground,
                            borderRadius: BorderRadius.circular(context.borderRadiusLx),
                            border: Border.all(
                              color: AppColors.chipBorder,
                              width: context.borderWidthThin,
                            ),
                          ),
                          child: Text(
                            topic,
                            style: AppTextStyles.chipText(context),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: context.md),
                    Padding(
                      padding: EdgeInsets.only(right: context.defaultSpace),
                      child: DifficultyChip(
                        difficulty: DifficultyLevel.fromString(interviewItem.difficulty),
                        isSelected: true,
                        onSelected: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
