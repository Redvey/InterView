import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/strings.dart';


class BasicDetailsPrivacyNotice extends StatelessWidget {
  const BasicDetailsPrivacyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.successLight.withAlpha((1 * 255).round()),
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: AppColors.success,
          width: context.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: AppColors.success, size: context.iconSizeMD),
          SizedBox(width: context.sm),
          Expanded(
            child: Text(
              AppStrings.privacyNotice,
              style: context.hintTextColorful(color: AppColors.darkGreen),
            ),
          ),
        ],
      ),
    );
  }
}
