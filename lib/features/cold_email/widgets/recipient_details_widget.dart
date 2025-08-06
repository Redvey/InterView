import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/colors.dart';
import '../../resume/widgets/labelled_text_field.dart';


class RecipientDetailsWidget extends StatelessWidget {
  final TextEditingController recipientController;
  final TextEditingController recipientEmailController;
  final TextEditingController companyController;
  final TextEditingController positionController;
  final VoidCallback onPersonalize;

  const RecipientDetailsWidget({
    super.key,
    required this.recipientController,
    required this.recipientEmailController,
    required this.companyController,
    required this.positionController,
    required this.onPersonalize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.searchBorder,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blackLight.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipient Details",
            style: context.infoSmallHeaderStyle
          ),
          const SizedBox(height: 12),

          // Replace first TextFormField with LabeledTextFormField
          LabeledTextFormField(
            label: "Recipient Email",
            hint: "Enter recipient's email address",
            controller: recipientEmailController,
            containerColor: AppColors.searchBorder,
            borderColor: AppColors.backgroundWhite,
            fieldType: FieldType.email,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
          ),

          // Replace Row with two TextFormFields
          Row(
            children: [
              Expanded(
                child: LabeledTextFormField(
                  label: "Recipient Name",
                  hint: "Enter recipient's name",
                  controller: recipientController,
                  containerColor: AppColors.searchBorder,
                  borderColor: AppColors.backgroundWhite,
                  fieldType: FieldType.name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabeledTextFormField(
                  label: "Company",
                  hint: "Enter company name",
                  controller: companyController,
                  containerColor: AppColors.searchBorder,
                  borderColor: AppColors.backgroundWhite,
                  fieldType: FieldType.company,
                ),
              ),
            ],
          ),

          // Replace last TextFormField
          LabeledTextFormField(
            label: "Position/Field of Interest",
            hint: "Enter position or field of interest",
            controller: positionController,
            containerColor: AppColors.searchBorder,
            borderColor: AppColors.backgroundWhite,
            fieldType: FieldType.jobTitle,
            isLastField: true,
          ),

          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onPersonalize,
            icon: const Icon(Icons.auto_fix_high),
            label:  Text("Personalize Email",style: context.buttonWhiteTextStyle,),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blackLight,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}