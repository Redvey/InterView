import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import '../../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
import '../controllers/resume_review_controllers.dart';
import '../widgets/jd_input_field.dart';
import '../widgets/prompt_button.dart';
import '../../widgets/upload_download_button.dart';

class ResumeReviewScreen extends StatefulWidget {
  const ResumeReviewScreen({super.key});

  @override
  State<ResumeReviewScreen> createState() => _ResumeReviewScreenState();
}

class _ResumeReviewScreenState extends State<ResumeReviewScreen> {
  final controller = ResumeReviewController();
  String? loadingPrompt; // which prompt is loading

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.all( context.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ResumeFormTopBar(pageColor: AppColors.blackLight, title: AppStrings.resumeReviewTitle,),
                  const SizedBox(height: 16),

                  // JD Input Field
                  JDInputField(controller: controller.jdController),
                  const SizedBox(height: 16),

                  // Resume Upload Button
                  UploadDownloadButton(
                    icon: Icons.upload_file,
                    process: AppStrings.uploadResume,
                    fileName: controller.fileName,
                    onPick: () async {
                      final picked = await controller.pickResume();
                      if (picked != null) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Prompt Section
                  const Text(
                    AppStrings.runPrompts,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: controller.promptLabels.map((label) {
                      return PromptButton(
                        label: label,
                        backgroundColor: controller.getColor(label),
                        textColor: controller.getTextColor(label),
                        isLoading: loadingPrompt == label,
                        onPressed: () async {
                          setState(() => loadingPrompt = label);
                          final success = await controller.handleSubmit(
                            label,
                                () => controller.showCustomBottomSheet(
                              label,
                              context,
                            ),
                            context,
                          );
                          if (success) {
                            setState(() => loadingPrompt = null);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
