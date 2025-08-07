import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class NoFilesPlaceholder extends StatelessWidget {
  const NoFilesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: context.defaultSpaceH),
      padding: EdgeInsets.all(context.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.searchFill,
        borderRadius: BorderRadius.circular(context.radiusSM),
        border: Border.all(
          color: AppColors.searchBorder,
          style: BorderStyle.solid,
          width: context.borderWidthThin,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: context.iconSize,
            color: AppColors.socialForm,
          ),
          SizedBox(height: context.sm),
          Text(
            AppStrings.noFilesAttached,
            style: context.emptyStateHintStyle.copyWith(color: AppColors.blackLight),
          ),
          SizedBox(height: context.xs),
          Text(
            AppStrings.tapToAttach,
            style: context.emptyStateHintStyle.copyWith(
              fontSize: context.fontSizeSs,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}