import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/themes/text_styles.dart';
import 'package:interview/shared/widgets/labelled_text_field.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.generalInformation;

    // Focus nodes for field-to-field navigation
    final firstNameFocus = FocusNode();
    final lastNameFocus = FocusNode();
    final bioFocus = FocusNode();
    final experienceFocus = FocusNode();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.generalInformation, style: AppTextStyles.infoHeader),
                SizedBox(height: AppSizes.spaceBtwFields),

                LabeledTextField(
                  label: AppStrings.firstName,
                  hint: AppStrings.hintFirstName,
                  containerColor: backgroundColor,
                  focusNode: firstNameFocus,
                  nextFocus: lastNameFocus,
                ),
                LabeledTextField(
                  label: AppStrings.lastName,
                  hint: AppStrings.lastName,
                  containerColor: backgroundColor,
                  focusNode: lastNameFocus,
                  nextFocus: bioFocus,
                ),
                LabeledTextField(
                  label: AppStrings.shortBio,
                  hint: AppStrings.bio,
                  containerColor: backgroundColor,
                  maxLines: 3,
                  focusNode: bioFocus,
                  nextFocus: experienceFocus,
                ),
                LabeledTextField(
                  label: AppStrings.yearsOfExperience,
                  hint: AppStrings.experience,
                  keyboardType: TextInputType.number,
                  containerColor: backgroundColor,
                  focusNode: experienceFocus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
