import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';

class ResumeBuilderFinalScreen extends StatefulWidget {
  const ResumeBuilderFinalScreen({super.key});

  @override
  ResumeBuilderFinalScreenState createState() => ResumeBuilderFinalScreenState();
}

class ResumeBuilderFinalScreenState extends State<ResumeBuilderFinalScreen> {
  final int _selectedTemplateIndex = 0;

  final List<String> templateThumbnails = [
    'assets/templates/template1.png',
    'assets/templates/template2.png',
    // add more templates
  ];

  void _buildResume() {
    final selectedTemplate = _selectedTemplateIndex;
    // TODO: Pass form data and template to backend or local PDF builder
    // Then save as resume.pdf and show confirmation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Template")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Resume PDFs", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            _buildResumeFileList(),

            const SizedBox(height: 16),
            Text("Templates", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            _buildTemplateSelector(),

            const Spacer(),
            ElevatedButton(
              onPressed: _buildResume,
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50),backgroundColor: AppColors.blackLight),
              child: const Text("Build Resume ✨", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateSelector() {
    return Row(
      children: List.generate(templateThumbnails.length, (index) {
        final isSelected = index == _selectedTemplateIndex;
        return Expanded(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(templateThumbnails[index]),
                  ),
                  if (isSelected)
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(Icons.check_circle, color: Colors.green),
                    )
                ],
              ),
              TextButton(
                onPressed: () {
                  // TODO: Show preview page
                },
                child: const Text("Preview"),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildResumeFileList() {
    // Replace with ListView.builder if dynamic
    return Row(
      children: [
        _pdfChip("Roopam.pdf", "a minute ago"),
        _pdfChip("Roopam.pdf", "4 minutes ago"),
      ],
    );
  }

  Widget _pdfChip(String name, String time) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
          Text(name),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
