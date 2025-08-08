import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';

class PlaceholderAlertDialog extends StatelessWidget {
  final List<String> unfilledPlaceholders;

  const PlaceholderAlertDialog({
    super.key,
    required this.unfilledPlaceholders,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radiusLG),
      ),
      title: Row(
        children: [
          const Icon(Icons.warning, color: AppColors.warning),
          SizedBox(width: context.mxs),
          Text(
            AppStrings.incompleteEmail,
            style: context.sectionTitleStyle,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.fillPlaceholders,
            style: context.hintTextStyle(color: AppColors.textGrey),
          ),
          SizedBox(height: context.spaceBtwItemsH),
          Container(
            padding: EdgeInsets.all(context.paddingMD),
            decoration: BoxDecoration(
              color: AppColors.warning,
              borderRadius: BorderRadius.circular(context.radiusSM),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: unfilledPlaceholders.map((placeholder) => Padding(
                padding: EdgeInsets.symmetric(vertical: context.paddingXS / 2),
                child: Text(
                  '• $placeholder',
                  style: context.bodyBoldStyle.copyWith(
                    color: AppColors.white,
                    fontSize: context.fontSizeSm,
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
          child: Text(
            AppStrings.ok,
            style: context.snackBarTextStyle,
          ),
        ),
      ],
    );
  }
}