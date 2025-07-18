import 'package:flutter/material.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_final_widgets/resume_pdf_chip.dart';
import '../model/resume_data.dart';


class RecentResumesSection extends StatelessWidget {
  final List<ResumeData> recentResumes;

  const RecentResumesSection({
    super.key,
    required this.recentResumes,
  });

  @override
  Widget build(BuildContext context) {
    if (recentResumes.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        child: Text(
          'No recent resumes',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: recentResumes
            .map((resume) => ResumePdfChip(
          resume: resume,
          onTap: () => _onResumeTap(context, resume),
        ))
            .toList(),
      ),
    );
  }

  void _onResumeTap(BuildContext context, ResumeData resume) {
    // TODO: Implement resume tap action (preview, download, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tapped on ${resume.fileName}')),
    );
  }
}