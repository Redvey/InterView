import 'package:flutter/material.dart';
import 'package:interview/core/themes/text_styles.dart';
import '../../../core/constants/colors.dart';

InputDecoration whiteInputDecoration(String hint, Color hintColor) =>
    InputDecoration(
      filled: true,
      fillColor: AppColors.backgroundWhite,
      hintText: hint,
      hintStyle: AppTextStyles.hintText(color: hintColor),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundWhite),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundWhite, width: 2),
      ),
    );
