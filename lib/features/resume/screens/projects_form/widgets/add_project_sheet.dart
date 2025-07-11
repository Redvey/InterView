import 'package:flutter/material.dart';
import 'package:interview/core/utils/color_utils.dart';

import '../../../../../core/constants/colors.dart';
import '../../../widgets/labelled_text_field.dart';

class AddProjectSheet extends StatefulWidget {
  final void Function(String title, String about, String github, String live) onAdd;

  const AddProjectSheet({super.key, required this.onAdd});

  @override
  State<AddProjectSheet> createState() => _AddProjectSheetState();
}

class _AddProjectSheetState extends State<AddProjectSheet> {
  final _titleController = TextEditingController();
  final _aboutController = TextEditingController();
  final _githubController = TextEditingController();
  final _liveController = TextEditingController();

  void _handleAdd() {
    final title = _titleController.text.trim();
    final about = _aboutController.text.trim();
    final github = _githubController.text.trim();
    final live = _liveController.text.trim();

    if (title.isEmpty || about.isEmpty) return;

    widget.onAdd(title, about, github, live);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.projectForm,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add Project", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            LabeledTextField(
              label: "Project Title",
              hint: "Enter project title",
              controller: _titleController,
              containerColor: darkerProjectColor,
            ),
            LabeledTextField(
              label: "About the Project",
              hint: "Enter details",
              controller: _aboutController,
              maxLines: 3,
              containerColor:darkerProjectColor,
            ),
            LabeledTextField(
              label: "GitHub Link",
              hint: "Paste GitHub URL",
              controller: _githubController,
              containerColor:darkerProjectColor,
            ),
            LabeledTextField(
              label: "Live Link",
              hint: "Paste live URL (optional)",
              controller: _liveController,
              containerColor:darkerProjectColor,

            ),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _handleAdd,
                child: const Text("Add"),
              ),
            )
          ],
        ),
      ),
    );
  }


}
