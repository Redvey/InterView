import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../app/themes/text_styles.dart';
import '../../../core/constants/colors.dart';


class InputDecorationHelper {
  static InputDecoration buildInputDecoration(String hintText,BuildContext context) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.hintText(context, color: AppColors.textGrey),
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide:   BorderSide(
          color: AppColors.backgroundRed,
          width: context.borderWidthThin,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide:   BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide:   BorderSide(
          color: AppColors.red,
          width: context.borderWidthThin,
        ),
      ),
      contentPadding:   EdgeInsets.symmetric(
        horizontal: context.paddingLG,
        vertical: context.paddingMD,
      ),
    );
  }
}