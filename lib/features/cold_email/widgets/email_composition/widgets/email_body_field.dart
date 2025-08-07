import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

class EmailBodyField extends StatelessWidget {
  final TextEditingController bodyController;

  const EmailBodyField({
    super.key,
    required this.bodyController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.emailBodyHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LabeledTextFormField(
              label: AppStrings.emailBody,
              hint: AppStrings.hintEmailBody,
              controller: bodyController,
              containerColor: AppColors.searchBorder,
              borderColor: AppColors.backgroundWhite,
              fieldType: FieldType.multiline,
              isRequired: true,
              maxLines: context.maxLinesEmailBody,
              validator: (value) {
                // Check if the field is empty
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.fieldRequired;
                }
                // Check for minimum length
                if (value.trim().length < 10) {
                  // Consider adding a constant for this message in AppStrings
                  return AppStrings.tenCharacters;
                }
                // Return null if validation passes
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
