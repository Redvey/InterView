import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';


class PreferenceSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const PreferenceSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.paddingSM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.detailHeaderStyle,
                ),
                SizedBox(height: context.xs),
                Text(
                  subtitle,
                  style: context.hintTextGreyStyle,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.darkPurple,
            activeTrackColor: AppColors.purpleLight,
            inactiveThumbColor: AppColors.grey500,
            inactiveTrackColor: AppColors.grey300,
          ),
        ],
      ),
    );
  }
}