import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';


class PreferenceDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;

  const PreferenceDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
          borderSide: BorderSide(color: AppColors.grey400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
          borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.paddingMD,
          vertical: context.paddingSM,
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      hint: Text(hint),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style:  TextStyle(
              fontSize: context.fontSizeSx,
              color: Colors.black87,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: AppColors.white,
      style:  TextStyle(
        fontSize: context.fontSizeSx,
        color: Colors.black87,
      ),
    );
  }
}
