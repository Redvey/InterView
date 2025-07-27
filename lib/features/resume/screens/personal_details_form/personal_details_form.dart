import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import 'package:interview/core/constants/colors.dart';

import '../../widgets/labelled_text_field.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({super.key});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _experienceController = TextEditingController();

  // Focus nodes
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _bioFocus = FocusNode();
  final _experienceFocus = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _experienceController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _bioFocus.dispose();
    _experienceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.generalInformation;

    return Padding(
      padding: EdgeInsets.all(context.paddingMD),
      child: Container(
        padding: EdgeInsets.all(context.paddingMD),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: context.screenHeight * 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.generalInformation, style: context.infoHeaderStyle),
                  SizedBox(height: context.spaceBtwFields),

                  LabeledTextFormField(
                    label: AppStrings.firstName,
                    hint: AppStrings.hintFirstName,
                    controller: _firstNameController,
                    containerColor: backgroundColor,
                    focusNode: _firstNameFocus,
                    nextFocus: _lastNameFocus,
                    fieldType: FieldType.name,
                    isRequired: true,
                  ),
                  SizedBox(height: context.spaceBtwInputFields),

                  LabeledTextFormField(
                    label: AppStrings.lastName,
                    hint: AppStrings.hintLastName,
                    controller: _lastNameController,
                    containerColor: backgroundColor,
                    focusNode: _lastNameFocus,
                    nextFocus: _bioFocus,
                    fieldType: FieldType.name,
                    isRequired: true,
                  ),
                  SizedBox(height: context.spaceBtwInputFields),

                  LabeledTextFormField(
                    label: AppStrings.shortBio,
                    hint: AppStrings.bio,
                    controller: _bioController,
                    containerColor: backgroundColor,
                    maxLines: context.textFieldMaxLines,
                    focusNode: _bioFocus,
                    nextFocus: _experienceFocus,
                    fieldType: FieldType.description,
                    isRequired: true,
                  ),
                  SizedBox(height: context.spaceBtwInputFields),

                  LabeledTextFormField(
                    label: AppStrings.yearsOfExperience,
                    hint: AppStrings.experience,
                    controller: _experienceController,
                    containerColor: backgroundColor,
                    focusNode: _experienceFocus,
                    fieldType: FieldType.experience,
                    isRequired: true,
                    isLastField: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
