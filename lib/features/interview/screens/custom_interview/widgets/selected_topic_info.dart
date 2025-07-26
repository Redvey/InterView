import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

import '../../../../../app/themes/text_styles.dart';
import '../../../../../core/constants/colors.dart';

class TopicsInfoWidget extends StatelessWidget {
  final int selectedTopicsCount;

  const TopicsInfoWidget({super.key, required this.selectedTopicsCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all( context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular( context.radiusSM),
        border: Border.all(color: AppColors.blue200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.blue600,
            size:  context.iconSizeMD,
          ),
           SizedBox(width:  context.sm),
          Text(
            '$selectedTopicsCount ${AppStrings.topicsSelected}',
            style: AppTextStyles.infoText(context),
          ),
        ],
      ),
    );
  }
}
