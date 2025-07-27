import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/colors.dart';

InputDecoration whiteInputDecoration(
  BuildContext context,
  String hint,
  Color hintColor,
  Color borderColor,
) => InputDecoration(
  filled: true,
  fillColor: AppColors.backgroundWhite,
  hintText: hint,
  hintStyle: context.hintTextStyle(color: hintColor),
  border: const OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: hintColor, width: 1),
  ),
);

