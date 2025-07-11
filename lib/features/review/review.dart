
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

import '../../core/constants/sizes.dart';
import '../resume/screens/roles_form/widget/response_sheet.dart';

class ResumeReviewScreen extends StatefulWidget {
  const ResumeReviewScreen({super.key});

  @override
  State<ResumeReviewScreen> createState() => _ResumeReviewScreenState();
}

class _ResumeReviewScreenState extends State<ResumeReviewScreen> {
  final TextEditingController jdController = TextEditingController();
  String? fileName;
  bool isLoading = false;
  String? response;

  void pickResume() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (file != null) {
      setState(() {
        fileName = file.files.first.name;
      });
    }
  }

  void handleSubmit(String promptType) async {
    if (jdController.text.isEmpty || fileName == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.provideJD)));
      return;
    }

    setState(() => isLoading = true);

    // Simulated response delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
      response = 'Response for "$promptType" prompt will appear here.';
    });

    showCustomBottomSheet("Tell me about the resume",
      response,
      isLoading,);
  }

  void showCustomBottomSheet(String promptTitle, String? response, bool isLoading) {
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



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Padding(
          padding: const EdgeInsets.only(
            top: AppSizes.xl,
            left: AppSizes.lg,
            right: AppSizes.lg,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(onPressed: () => context.pop()),
                    Text(AppStrings.resumeReviewTitle),
                    CircleAvatar(),
                  ],
                ),
                const SizedBox(height: 16),
                LabeledTextField(
                  controller: jdController,
                  maxLines: 6,
                  label: AppStrings.jobDescription,
                  hint: AppStrings.pasteJobDesc,
                  containerColor: AppColors.textYellow,
                ),
                const SizedBox(height: 16),

                // Upload Resume
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0.5,
                    backgroundColor: AppColors.blackLight,

                  ),

                  onPressed: pickResume,
                  icon: const Icon(Icons.upload_file,color: AppColors.textGreen,),
                  label: Text(fileName ?? AppStrings.uploadResume,style: TextStyle(color: AppColors.textGreenBg),),
                ),
                const SizedBox(height: 24),

                // Action Buttons
                const Text(
                  AppStrings.runPrompts,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildPromptButton(
                      label: AppStrings.aboutResume,
                      backgroundColor: AppColors.buttonPurple,
                      textColor: AppColors.buttonTextPurple,
                    ),
                    _buildPromptButton(
                      label: AppStrings.improviseSkill,
                      backgroundColor: AppColors.buttonBlue,
                      textColor: AppColors.buttonTextBlue,
                    ),
                    _buildPromptButton(
                      label: AppStrings.missingKeywords,
                      backgroundColor: AppColors.buttonGray,
                      textColor: AppColors.buttonTextGray,
                    ),
                    _buildPromptButton(
                      label: AppStrings.percentageMatch,
                      backgroundColor: AppColors.buttonRed,
                      textColor: AppColors.buttonTextRed,
                    ),
                    ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromptButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.5,
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: isLoading ? null : () => handleSubmit(label),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
    );
  }
}
