import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

import '../model/resume_data.dart';

class ResumePdfChip extends StatelessWidget {
  final ResumeData resume;
  final VoidCallback? onTap;

  const ResumePdfChip({
    super.key,
    required this.resume,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: context.spaceLess),
        padding: EdgeInsets.all(context.spaceLess / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(context.borderRadiusMd),
        ),
        child: Column(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
            SizedBox(height: context.spaceLess / 2),
            Text(
              resume.fileName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              resume.timeAgo,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
