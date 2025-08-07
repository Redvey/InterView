import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/color_utils.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../utils/file_formatter.dart';

class AttachedFileItem extends StatelessWidget {
  final PlatformFile file;
  final VoidCallback onRemove;

  const AttachedFileItem({
    super.key,
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using a combination of existing sizes for the width
      width: context.attachedFileItemWidth,
      height: context.attachedFileItemHeight,
      margin: EdgeInsets.only(right: context.paddingMD),
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(context.radiusSM),
        border: Border.all(
          color: AppColors.blue800,
          width: context.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                getFileIcon(file.name),
                size: context.iconSize,
                color: AppColors.blue800,
              ),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: EdgeInsets.all(context.radiusXS),
                  decoration:  BoxDecoration(
                      color: darkerEducationColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.close,
                    size: context.iconSizeSX,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.sm),
          Expanded(
            child: Text(
              file.name,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                  fontSize: context.fontSizeSs, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            formatFileSize(file.size),
            style: TextStyle(
              fontFamily: AppFonts.poppins,
                fontSize: context.fontSizeSten, color: AppColors.greyDark),
          ),
        ],
      ),
    );
  }
}