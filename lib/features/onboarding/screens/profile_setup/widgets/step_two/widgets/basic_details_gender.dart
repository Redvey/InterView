import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../../../core/constants/strings.dart';


class BasicDetailsGenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final List<String> genderOptions;
  final ValueChanged<String?> onChanged;

  const BasicDetailsGenderDropdown({
    super.key,
    required this.selectedGender,
    required this.genderOptions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      decoration: InputDecoration(
        labelText: AppStrings.genderLabel,
        hintText: AppStrings.genderHint,
        prefixIcon: Icon(Icons.people_outline, size: context.iconSizeMD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
      ),
      items: genderOptions
          .map((gender) => DropdownMenuItem(
        value: gender,
        child: Text(gender, style: context.textFieldStyle),
      ))
          .toList(),
      onChanged: onChanged,
      validator: (value) =>
      (value == null || value.isEmpty) ? AppStrings.genderEmptyError : null,
    );
  }
}
