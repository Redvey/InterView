import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Focus nodes
  final _locationFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void dispose() {
    _locationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.paddingMD),
      child: Container(
        padding: EdgeInsets.all(context.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.contactForm,
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.contactForm, style: context.infoHeaderStyle),
                SizedBox(height: context.spaceBtwFields),

                LabeledTextFormField(
                  label: AppStrings.basedOutOf,
                  hint: AppStrings.hintCityOrLocation,
                  controller: _locationController,
                  containerColor: AppColors.contactForm,
                  focusNode: _locationFocus,
                  nextFocus: _emailFocus,
                  fieldType: FieldType.location,
                  isRequired: true,
                ),

                LabeledTextFormField(
                  label: AppStrings.email,
                  hint: AppStrings.hintEmail,
                  controller: _emailController,
                  containerColor: AppColors.contactForm,
                  focusNode: _emailFocus,
                  nextFocus: _phoneFocus,
                  fieldType: FieldType.email,
                  isRequired: true,
                ),

                LabeledTextFormField(
                  label: AppStrings.phn,
                  hint: AppStrings.hintPhn,
                  controller: _phoneController,
                  containerColor: AppColors.contactForm,
                  focusNode: _phoneFocus,
                  fieldType: FieldType.phone,
                  isRequired: true,
                  isLastField: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
