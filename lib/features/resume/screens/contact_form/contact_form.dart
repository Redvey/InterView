import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.contactForm,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.contactForm, style:  context.infoHeaderStyle),
              const SizedBox(height: 16),

              LabeledTextField(
                label: AppStrings.basedOutOf,
                hint: AppStrings.hintCityOrLocation,
                containerColor: AppColors.contactForm,
              ),
              LabeledTextField(
                label: AppStrings.email,
                hint: AppStrings.hintEmail,
                keyboardType: TextInputType.emailAddress,
                containerColor: AppColors.contactForm,
              ),
              LabeledTextField(
                label: AppStrings.phn,
                hint: AppStrings.hintPhn,
                keyboardType: TextInputType.phone,
                containerColor: AppColors.contactForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
