import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/strings.dart';


class BasicDetailsHeader extends StatelessWidget {
  const BasicDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.basicInfoTitle,
          style: context.headingStyle(color: AppColors.black87),
        ),
        SizedBox(height: context.sm),
        Text(
          AppStrings.basicInfoSubtitle,
          style: context.subheadingStyle(color: AppColors.textGrey),
        ),
      ],
    );
  }
}
