import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class InfoBox extends StatelessWidget {
  final String message;

  const InfoBox({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: AppColors.success,
          width: context.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline,
              color: AppColors.success, size: context.iconSizeMD),
          SizedBox(width: context.sm),
          Expanded(
            child: Text(
              message,
              style: context.hintTextColorful(color: AppColors.darkGreen),
            ),
          ),
        ],
      ),
    );
  }
}
