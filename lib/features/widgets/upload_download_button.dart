import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class UploadDownloadButton extends StatelessWidget {
  final String? fileName;
  final VoidCallback onPick;
  final IconData icon;
  final String process;
  final double buttonPaddingW;
  final double buttonPaddingH;

  const UploadDownloadButton({
    super.key,
    required this.fileName,
    required this.onPick,
    required this.icon,
    required this.process,
    this.buttonPaddingW=12,
    this.buttonPaddingH=14,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPick,
      icon: Icon(icon, color: AppColors.textGreen),
      label: Text(fileName ?? process, style: context.buttonWhiteTextStyle),
      style: ElevatedButton.styleFrom(
        padding:  EdgeInsets.symmetric(horizontal: buttonPaddingW, vertical: buttonPaddingH),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.buttonRadius)),
        elevation: 0.5,
        backgroundColor: AppColors.blackLight,
      ),
    );
  }
}
