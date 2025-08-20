import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/review/widgets/response_sheet.dart';

import '../utils/resume_review_utils.dart';

class ResumeReviewController {
  final TextEditingController jdController = TextEditingController();
  String? fileName;
  bool isLoading = false;
  String? response;

  /// Labels for AI prompt buttons
  final List<String> promptLabels = [
    AppStrings.aboutResume,
    AppStrings.improviseSkill,
    AppStrings.missingKeywords,
    AppStrings.percentageMatch,
  ];

  /// Picks a resume and updates fileName
  Future<String?> pickResume() async {
    final file = await ResumeReviewUtils.pickResumeFile();
    if (file != null) {
      fileName = file.name;
    }
    return fileName;
  }

  /// Handles prompt submission logic with safe context usage
  Future<bool> handleSubmit(
      String promptType,
      VoidCallback openBottomSheet,
      BuildContext context,
      ) async {
    if (jdController.text.isEmpty || fileName == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.provideJD)),
        );
      }
      return false;
    }

    isLoading = true;

    // Simulated delay for AI response
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    response = 'Response for "$promptType" prompt will appear here.';

    openBottomSheet();
    return true;
  }

  /// Used as a callback to show the bottom sheet
  void showCustomBottomSheet(String promptTitle, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AiResponseBottomSheet(
        promptTitle: promptTitle,
        response: response,
        isLoading: isLoading,
      ),
    );
  }

  /// Returns background color for a given prompt
  Color getColor(String label) {
    switch (label) {
      case AppStrings.aboutResume:
        return AppColors.buttonPurple;
      case AppStrings.improviseSkill:
        return AppColors.buttonBlue;
      case AppStrings.missingKeywords:
        return AppColors.buttonGray;
      case AppStrings.percentageMatch:
        return AppColors.buttonRed;
      default:
        return Colors.grey;
    }
  }

  /// Returns text color for a given prompt
  Color getTextColor(String label) {
    switch (label) {
      case AppStrings.aboutResume:
        return AppColors.buttonTextPurple;
      case AppStrings.improviseSkill:
        return AppColors.buttonTextBlue;
      case AppStrings.missingKeywords:
        return AppColors.buttonTextGray;
      case AppStrings.percentageMatch:
        return AppColors.buttonTextRed;
      default:
        return Colors.white;
    }
  }

  void dispose() {
    jdController.dispose();
  }
}
