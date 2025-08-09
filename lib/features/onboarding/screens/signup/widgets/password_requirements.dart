import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(color: AppColors.blue200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Requirements:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.blue800,
              fontSize: context.fontSizeSm,
            ),
          ),
          SizedBox(height: context.sm),
          _buildRequirement(context, 'At least 8 characters'),
          _buildRequirement(context, 'One uppercase letter'),
          _buildRequirement(context, 'One number'),
        ],
      ),
    );
  }

  Widget _buildRequirement(BuildContext context, String requirement) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.paddingXS / 2),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: context.iconSizeSX, color: AppColors.blue600),
          SizedBox(width: context.sm),
          Text(
            requirement,
            style: TextStyle(fontSize: context.fontSizeSs, color: AppColors.blue700),
          ),
        ],
      ),
    );
  }
}