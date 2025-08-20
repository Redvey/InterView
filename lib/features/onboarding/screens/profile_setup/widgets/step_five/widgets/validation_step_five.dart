// widgets/validation_message.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';

class ValidationMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  const ValidationMessage({
    super.key,
    required this.message,
    this.icon = Icons.warning_outlined,
    this.backgroundColor = AppColors.errorLight,
    this.borderColor = AppColors.error,
    this.textColor = AppColors.error,
    this.iconColor = AppColors.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: borderColor,
          width: context.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: context.iconSizeMD,
          ),
          SizedBox(width: context.sm),
          Expanded(
            child: Text(
              message,
              style: context.hintTextColorful(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}