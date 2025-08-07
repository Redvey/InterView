import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class EmailActionButtons extends StatelessWidget {
  final VoidCallback onSaveDraft;
  final VoidCallback onSendEmail;

  const EmailActionButtons({
    super.key,
    required this.onSaveDraft,
    required this.onSendEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSaveDraft,
            icon:  Icon(Icons.save,color: AppColors.white,),
            label: Text(
              AppStrings.saveDraft,
              style: context.buttonWhiteTextStyle,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greyDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radiusMD),
              ),
            ),
          ),
        ),
        SizedBox(width: context.defaultSpace),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSendEmail,
            icon: const Icon(Icons.send),
            label: Text(
              AppStrings.sendEmail,
              style: context.buttonWhiteTextStyle,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blackLight,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radiusMD),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
