import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';

class ResumeUploadButton extends StatelessWidget {
  final String? fileName;
  final VoidCallback onPick;

  const ResumeUploadButton({
    super.key,
    required this.fileName,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPick,
      icon: const Icon(Icons.upload_file, color: AppColors.textGreen),
      label: Text(
        fileName ?? AppStrings.uploadResume,
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
