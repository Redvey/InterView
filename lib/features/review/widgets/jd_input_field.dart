import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

class JDInputField extends StatelessWidget {
  final TextEditingController controller;

  const JDInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledTextField(
      // showBorder: true,
      controller: controller,
      maxLines: 8,
      label: AppStrings.jobDescription,
      keyboardType: TextInputType.multiline,
      hint: AppStrings.pasteJobDesc,
      containerColor: AppColors.textYellow,
      borderColor: AppColors.backgroundOrange,

    );
  }
}
