import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
import 'package:interview/features/resume/widgets/template_preview.dart';

import '../../widgets/upload_download_button.dart';

class ResumeBuilderFinalScreen extends StatefulWidget {
  const ResumeBuilderFinalScreen({super.key});

  @override
  State<ResumeBuilderFinalScreen> createState() => _ResumeBuilderFinalScreenState();
}

class _ResumeBuilderFinalScreenState extends State<ResumeBuilderFinalScreen> {
  int _selectedTemplateIndex = 0;

  final List<String> _templateThumbnails = [
    'assets/templates/template2.jpeg',
    'assets/templates/template2.jpeg',
  ];

  void _buildResume() {
    final selectedTemplate = _selectedTemplateIndex;
    // TODO: Send selectedTemplate and form data to backend or PDF generator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: AppSizes.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeFormTopBar(pageColor: AppColors.blackLight),
                SizedBox(height: AppSizes.spaceBtwItems),
                _sectionTitle(context, "Resume PDFs"),
                SizedBox(height: AppSizes.spaceBtwItems),
                _buildRecentResumes(),

                SizedBox(height: AppSizes.spaceBtwItems),
                _sectionTitle(context, "Templates"),
                SizedBox(height: AppSizes.spaceLess),
                _buildTemplateSelector(),
                SizedBox(height: AppSizes.spaceLess),
              SizedBox(
                width: double.infinity,
                child: UploadDownloadButton(
                    fileName: "Build Resume ✨",
                    onPick: _buildResume,
                  icon: Icons.download,
                  process: '',),
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildRecentResumes() {
    final List<Map<String, String>> recentResumes = [
      {"name": "Roopam.pdf", "time": "a minute ago"},
      {"name": "Roopam.pdf", "time": "4 minutes ago"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: recentResumes
            .map((resume) => _pdfChip(resume["name"]!, resume["time"]!))
            .toList(),
      ),
    );
  }

  Widget _pdfChip(String name, String time) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: AppSizes.spaceLess),
      padding: EdgeInsets.all(AppSizes.spaceLess / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      child: Column(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
          SizedBox(height: AppSizes.spaceLess / 2),
          Text(name, textAlign: TextAlign.center),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildTemplateSelector() {
    return Row(
      children: List.generate(_templateThumbnails.length, (index) {
        final isSelected = index == _selectedTemplateIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTemplateIndex = index),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(AppSizes.spaceLess / 2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg / 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg / 2),
                        child: Image.asset(_templateThumbnails[index]),
                      ),
                    ),
                    if (isSelected)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(Icons.check_circle, color: Colors.green),
                      ),
                  ],
                ),
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => TemplatePreviewDialog(
                      templatePath: _templateThumbnails[index],
                    ),
                  ),
                  child: const Text("Preview"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
