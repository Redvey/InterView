import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/resume_form/widgets/template_preview.dart';

class ResumeBuilderFinalScreen extends StatefulWidget {
  const ResumeBuilderFinalScreen({super.key});

  @override
  State<ResumeBuilderFinalScreen> createState() =>
      _ResumeBuilderFinalScreenState();
}

class _ResumeBuilderFinalScreenState extends State<ResumeBuilderFinalScreen> {
  int _selectedTemplateIndex = 0;

  final List<String> _templateThumbnails = [
    'assets/templates/template1.jpeg',
    'assets/templates/template2.jpeg',
    // Add more templates if needed
  ];

  void _buildResume() {
    final selectedTemplate = _selectedTemplateIndex;
    // TODO: Send selectedTemplate and form data to backend or PDF generator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Template")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(context, "Resume PDFs"),
            const SizedBox(height: 8),
            _buildRecentResumes(),

            const SizedBox(height: 16),
            _sectionTitle(context, "Templates"),
            const SizedBox(height: 12),
            _buildTemplateSelector(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _buildResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blackLight,
                ),
                child: const Text(
                  "Build Resume ✨",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildRecentResumes() {
    // Replace with ListView.builder if dynamic
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
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
          const SizedBox(height: 6),
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
            onTap: () {
              setState(() => _selectedTemplateIndex = index);
            },
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
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
                  onPressed: () {
                    // TODO: Show full screen preview if needed
                    showDialog(
                      context: context,
                      builder: (_) => TemplatePreviewDialog(
                        templatePath: _templateThumbnails[index],
                      ),
                    );
                  },
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
