import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_final_widgets/recent_resume.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_final_widgets/template_selector_section.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';

import '../../widgets/upload_download_button.dart';
import '../controllers/resume_final_controllers.dart';


class ResumeBuilderFinalScreen extends StatefulWidget {
  const ResumeBuilderFinalScreen({super.key});

  @override
  State<ResumeBuilderFinalScreen> createState() => _ResumeBuilderFinalScreenState();
}

class _ResumeBuilderFinalScreenState extends State<ResumeBuilderFinalScreen> {
  late final ResumeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ResumeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: context.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeFormTopBar(
                  pageColor: AppColors.blackLight,
                  title: AppStrings.resumeBuilder,
                ),
                SizedBox(height: context.spaceBtwItems),
                _sectionTitle(context, AppStrings.resumePDF),
                SizedBox(height: context.spaceBtwItems),
                RecentResumesSection(
                  recentResumes: _controller.recentResumes,
                ),
                SizedBox(height: context.spaceBtwItems),
                _sectionTitle(context, AppStrings.templates),
                SizedBox(height: context.spaceLess),
                TemplateSelectorSection(
                  templates: _controller.templateThumbnails,
                  selectedIndex: _controller.selectedTemplateIndex,
                  onTemplateSelected: _controller.selectTemplate,
                ),
                SizedBox(height: context.spaceLess),
                SizedBox(
                  width: double.infinity,
                  child: UploadDownloadButton(
                    fileName: AppStrings.buildYourResume,
                    onPick: _controller.buildResume,
                    icon: Icons.download,
                    process: '',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Text(text, style: context.detailHeaderStyle);
  }
}