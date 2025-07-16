import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';

class UploadDownloadButton extends StatelessWidget {
  final String? fileName;
  final VoidCallback onPick;
  final IconData icon;
  final String process;

  const UploadDownloadButton({
    super.key,
    required this.fileName,
    required this.onPick, required this.icon, required this.process,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPick,
      icon:  Icon(icon, color: AppColors.textGreen),
      label: Text(
        fileName ?? process,
        style: const TextStyle(color: AppColors.textGreenBg),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0.5,
        backgroundColor: AppColors.blackLight,
      ),
    );
  }
}
