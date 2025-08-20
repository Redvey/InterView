import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../../../core/constants/colors.dart';


class PreferenceSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final IconData? icon;

  const PreferenceSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spaceBtwFields),
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: AppColors.grey300,
          width: context.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: AppColors.blackLight,
                  size: context.iconSizeMD,
                ),
                SizedBox(width: context.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.infoSmallHeaderStyle,
                    ),
                    SizedBox(height: context.xs),
                    Text(
                      subtitle,
                      style: context.hintTextGreyStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.paddingMD),
          child,
        ],
      ),
    );
  }
}
