import 'package:flutter/material.dart';

class TemplatePreviewDialog extends StatelessWidget {
  final String templatePath;

  const TemplatePreviewDialog({super.key, required this.templatePath});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              templatePath,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }
}
