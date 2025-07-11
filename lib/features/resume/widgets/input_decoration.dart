import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import '../../../core/constants/colors.dart';

InputDecoration whiteInputDecoration(String hint, Color hintColor) =>
    InputDecoration(
      filled: true,
      fillColor: AppColors.backgroundWhite,
      hintText: hint,
      hintStyle: AppTextStyles.hintText(color: hintColor),
      border: const OutlineInputBorder(),
      enabledBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundWhite),

      ),
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: hintColor, width: 1),
      ),
    );
