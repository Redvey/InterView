import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import '../../../../resume/widgets/labelled_text_field.dart';

class RecipientFormFields extends StatelessWidget {
  final TextEditingController recipientController;
  final TextEditingController recipientEmailController;
  final TextEditingController companyController;
  final TextEditingController positionController;

  const RecipientFormFields({
    super.key,
    required this.recipientController,
    required this.recipientEmailController,
    required this.companyController,
    required this.positionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledTextFormField(
          label: AppStrings.recipientEmail,
          hint: AppStrings.hintRecipientEmail,
          controller: recipientEmailController,
          containerColor: AppColors.searchBorder,
          borderColor: AppColors.backgroundWhite,
          fieldType: FieldType.email,
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: context.spaceBtwInputFields),

        Row(
          children: [
            Expanded(
              child: LabeledTextFormField(
                label: AppStrings.recipientName,
                hint: AppStrings.hintRecipientName,
                controller: recipientController,
                containerColor: AppColors.searchBorder,
                borderColor: AppColors.backgroundWhite,
                fieldType: FieldType.name,
              ),
            ),
            SizedBox(width: context.spaceBtwInputFields),
            Expanded(
              child: LabeledTextFormField(
                label: AppStrings.company,
                hint: AppStrings.hintCompanyName,
                controller: companyController,
                containerColor: AppColors.searchBorder,
                borderColor: AppColors.backgroundWhite,
                fieldType: FieldType.company,
              ),
            ),
          ],
        ),
        SizedBox(height: context.spaceBtwInputFields),

        LabeledTextFormField(
          label: AppStrings.positionTitle,
          hint: AppStrings.hintPositionTitle,
          controller: positionController,
          containerColor: AppColors.searchBorder,
          borderColor: AppColors.backgroundWhite,
          fieldType: FieldType.jobTitle,
          isLastField: true,
        ),
      ],
    );
  }
}
