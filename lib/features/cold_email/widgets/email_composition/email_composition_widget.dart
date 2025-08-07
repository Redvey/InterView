import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/cold_email/widgets/email_composition/widgets/email_actions_button.dart';
import 'package:interview/features/cold_email/widgets/email_composition/widgets/email_body_field.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

class EmailCompositionWidget extends StatelessWidget {
  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final VoidCallback onSaveDraft;
  final VoidCallback onSendEmail;

  const EmailCompositionWidget({
    super.key,
    required this.subjectController,
    required this.bodyController,
    required this.onSaveDraft,
    required this.onSendEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.md),
      decoration: BoxDecoration(
        color: AppColors.socialForm,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(color: AppColors.backgroundBlue.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.emailComposition,
            style: context.infoSmallHeaderStyle,
          ),
          SizedBox(height: context.defaultSpaceH),
          LabeledTextFormField(
            label: AppStrings.subject,
            hint: AppStrings.hintSubject,
            controller: subjectController,
            containerColor: AppColors.searchBorder,
            borderColor: AppColors.backgroundWhite,
            fieldType: FieldType.text,
            isRequired: true,
            requiredMessage: AppStrings.fieldRequired,
            maxLength: context.maxLinesEmailBody,
          ),
          SizedBox(height: context.defaultSpaceH),
          EmailBodyField(
            bodyController: bodyController,
          ),
          SizedBox(height: context.defaultSpaceH),
          EmailActionButtons(
            onSaveDraft: onSaveDraft,
            onSendEmail: onSendEmail,
          ),
        ],
      ),
    );
  }
}
