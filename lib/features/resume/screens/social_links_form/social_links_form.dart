import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/app/themes/text_styles.dart';

import '../../widgets/labelled_text_field.dart';



class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  State<SocialLinksForm> createState() => _SocialLinksFormState();
}

class _SocialLinksFormState extends State<SocialLinksForm> {
  final Map<String, TextEditingController> _controllers = {
    AppStrings.portfolio: TextEditingController(),
    AppStrings.linkedIn: TextEditingController(),
    AppStrings.github: TextEditingController(),
    AppStrings.codingProfile: TextEditingController(),
  };

  final List<String> _customLinks = [];

  void _addCustomLink() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Social Platform"),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Platform name (e.g., Twitter)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty && !_controllers.containsKey(name)) {
                setState(() {
                  _customLinks.add(name);
                  _controllers[name] = TextEditingController();
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _removeCustomLink(String name) {
    setState(() {
      _customLinks.remove(name);
      _controllers.remove(name);
    });
  }

  Widget _buildSocialField(String label, {bool removable = false}) {
    return LabeledTextField(
      label: label,
      hint: "Paste link",
      containerColor: AppColors.socialForm,
      controller: _controllers[label],
      removable: removable,
      onRemove: removable ? () => _removeCustomLink(label) : null,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> predefined = [
      AppStrings.portfolio,
      AppStrings.linkedIn,
      AppStrings.github,
      AppStrings.codingProfile,
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.socialForm,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.socialLink, style: AppTextStyles.infoHeader),
              const SizedBox(height: 16),

              // Predefined social link fields
              ...predefined.map((label) => _buildSocialField(label)),

              // Custom social link fields
              ..._customLinks.map((label) => _buildSocialField(label, removable: true)),

              // Add other button
              GestureDetector(
                onTap: _addCustomLink,
                child: const DottedBorderContainer(label: "+ Add Other"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final String label;
  const DottedBorderContainer({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
