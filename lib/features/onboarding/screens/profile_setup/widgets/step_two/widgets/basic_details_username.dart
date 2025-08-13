import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/strings.dart';



class BasicDetailsUsernameField extends StatelessWidget {
  final TextEditingController controller;
  const BasicDetailsUsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: AppStrings.usernameLabel,
        hintText: AppStrings.usernameHint,
        prefixIcon: Icon(Icons.alternate_email, size: context.iconSizeMD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
          borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) return AppStrings.usernameEmptyError;
        if (value!.length < 3) return AppStrings.usernameLengthError;
        if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
          return AppStrings.usernameFormatError;
        }
        return null;
      },
    );
  }
}
