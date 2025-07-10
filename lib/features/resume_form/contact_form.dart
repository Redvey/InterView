import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/themes/text_styles.dart';
import 'package:interview/shared/widgets/labelled_text_field.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.contactForm;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.contactForm, style: AppTextStyles.infoHeader),
              const SizedBox(height: 16),

              LabeledTextField(
                label: AppStrings.basedOutOf,
                hint: AppStrings.hintCityOrLocation,
                containerColor: backgroundColor,
              ),
              LabeledTextField(
                label: AppStrings.email,
                hint: AppStrings.hintEmail,
                keyboardType: TextInputType.emailAddress,
                containerColor: backgroundColor,
              ),
              LabeledTextField(
                label: AppStrings.phn,
                hint: AppStrings.hintPhn,
                keyboardType: TextInputType.phone,
                containerColor: backgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
