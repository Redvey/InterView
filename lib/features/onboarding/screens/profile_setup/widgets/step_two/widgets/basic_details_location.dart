import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/strings.dart';

class BasicDetailsLocationField extends StatelessWidget {
  final TextEditingController controller;
  const BasicDetailsLocationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: AppStrings.locationLabel,
        hintText: AppStrings.locationHint,
        prefixIcon: Icon(Icons.location_on_outlined, size: context.iconSizeMD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
      ),
      validator: (value) =>
      (value?.isEmpty ?? true) ? AppStrings.locationEmptyError : null,
    );
  }
}
