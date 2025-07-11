import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/utils/color_utils.dart';

class ExperienceTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const ExperienceTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.hintText(color: darkerJobColor),
        filled: true,
        fillColor: AppColors.backgroundWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
