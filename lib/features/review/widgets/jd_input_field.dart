import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

class JDInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isLastField;

  const JDInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.isLastField = true,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledTextFormField(
      controller: controller,
      maxLines: 8,
      label: AppStrings.jobDescription,
      hint: AppStrings.pasteJobDesc,
      containerColor: AppColors.textYellow,
      borderColor: AppColors.backgroundOrange,
      focusNode: focusNode,
      fieldType: FieldType.description,
      isRequired: true,
      isLastField: isLastField,
      // Custom validation for job descriptions
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Job description is required';
        }
        if (value.trim().length < 50) {
          return 'Job description should be at least 50 characters for better matching';
        }
        if (value.trim().length > 2000) {
          return 'Job description is too long (max 2000 characters)';
        }
        return null;
      },
    );
  }
}


