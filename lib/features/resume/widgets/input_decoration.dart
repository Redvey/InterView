import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import '../../../core/constants/colors.dart';

InputDecoration whiteInputDecoration(
  String hint,
  Color hintColor,
  Color borderColor,
) => InputDecoration(
  filled: true,
  fillColor: AppColors.backgroundWhite,
  hintText: hint,
  hintStyle: AppTextStyles.hintText(color: hintColor),
  border: const OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: hintColor, width: 1),
  ),
);
