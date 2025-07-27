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
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _aboutController = TextEditingController();
  final _githubController = TextEditingController();
  final _liveController = TextEditingController();

  final _titleFocus = FocusNode();
  final _aboutFocus = FocusNode();
  final _githubFocus = FocusNode();
  final _liveFocus = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _aboutController.dispose();
    _githubController.dispose();
    _liveController.dispose();
    _titleFocus.dispose();
    _aboutFocus.dispose();
    _githubFocus.dispose();
    _liveFocus.dispose();
    super.dispose();
  }

  void _handleAdd() {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text.trim();
      final about = _aboutController.text.trim();
      final github = _githubController.text.trim();
      final live = _liveController.text.trim();

      widget.onAdd(title, about, github, live);
      Navigator.pop(context);
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Project",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),

              LabeledTextFormField(
                label: "Project Title",
                hint: "Enter project title",
                controller: _titleController,
                containerColor: darkerProjectColor,
                focusNode: _titleFocus,
                nextFocus: _aboutFocus,
                fieldType: FieldType.projectTitle,
                isRequired: true,
              ),

              LabeledTextFormField(
                label: "About the Project",
                hint: "Enter project details and technologies used",
                controller: _aboutController,
                maxLines: 3,
                containerColor: darkerProjectColor,
                focusNode: _aboutFocus,
                nextFocus: _githubFocus,
                fieldType: FieldType.description,
                isRequired: true,
              ),

              LabeledTextFormField(
                label: "GitHub Link",
                hint: "https://github.com/username/project",
                controller: _githubController,
                containerColor: darkerProjectColor,
                focusNode: _githubFocus,
                nextFocus: _liveFocus,
                fieldType: FieldType.url,
                // Custom validation for GitHub URLs
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null; // GitHub link is optional
                  }

                  String url = value.trim().toLowerCase();
                  if (!url.startsWith('http://') && !url.startsWith('https://')) {
                    url = 'https://$url';
                  }

                  if (!url.contains('github.com')) {
                    return 'Please enter a valid GitHub URL';
                  }

                  return null;
                },
              ),

              LabeledTextFormField(
                label: "Live Link",
                hint: "https://your-project-demo.com (optional)",
                controller: _liveController,
                containerColor: darkerProjectColor,
                focusNode: _liveFocus,
                fieldType: FieldType.url,
                isLastField: true,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _handleAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blackLight,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Add Project"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
