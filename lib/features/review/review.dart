import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';

class ResumeReviewScreen extends StatefulWidget {
  const ResumeReviewScreen({super.key});

  @override
  State<ResumeReviewScreen> createState() => _ResumeReviewScreenState();
}
bool resumeUploaded = true;
class _ResumeReviewScreenState extends State<ResumeReviewScreen> {
  String? fileName;
  bool resumeUploaded = false;

  double score = 0.78; // 78% ATS match
  List<String> matchedSkills = ['Flutter', 'Firebase', 'REST APIs'];
  List<String> missingSkills = ['CI/CD', 'Teamwork'];
  Map<String, bool> sections = {
    'Contact Info': true,
    'Skills': true,
    'Experience': false,
    'Education': true,
    'Projects': false,
  };
  List<String> suggestions = [
    'Add a work experience section',
    'Mention CI/CD in skills',
    'Add relevant projects with impact',
  ];

  void pickResume() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (file != null) {
      setState(() {
        fileName = file.files.first.name;
        resumeUploaded = true;
      });

      // TODO: Upload to backend & get score
    }
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
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => context.pop(), // or Navigator.of(context).pop()
                ),
                resumeUploaded ? _buildReviewUI() : _buildUploadPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadPrompt() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: pickResume,
        icon: const Icon(Icons.upload_file),
        label: const Text("Upload Your Resume"),
      ),
    );
  }

  Widget _buildReviewUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Uploaded: $fileName", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // ATS Score
          Center(
            child: CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 8.0,
              percent: score,
              center: Text("${(score * 100).toInt()}%"),
              progressColor: Colors.green,
              backgroundColor: Colors.grey[300]!,
              animation: true,
              animationDuration: 600,
            ),
          ),
          const SizedBox(height: 20),

          // Missing Skills
          Text("❌ Missing Skills", style: Theme.of(context).textTheme.titleMedium),
          ...missingSkills.map((s) => Text("- $s")),

          const SizedBox(height: 20),

          // Suggestions
          Text("🔧 Suggestions", style: Theme.of(context).textTheme.titleMedium),
          ...suggestions.map((s) => Text("- $s")),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: pickResume,
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload Resume"),
          )
        ],
      ),
    );
  }
}
