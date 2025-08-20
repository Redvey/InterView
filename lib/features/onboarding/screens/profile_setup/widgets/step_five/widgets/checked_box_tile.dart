// widgets/custom_checkbox_tile.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;
  final Color activeColor;
  final Color checkColor;

  const CustomCheckboxTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.blackLight,
    this.checkColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.paddingMD),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: (val) => onChanged(val ?? false),
            activeColor: activeColor,
            checkColor: checkColor,
          ),
          SizedBox(width: context.sm),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.detailHeaderStyle,
                  ),
                  Text(
                    subtitle,
                    style: context.hintTextGreyStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}