import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class SkillForm extends StatefulWidget {
  const SkillForm({super.key});

  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final List<String> _skills = [];
  final TextEditingController _skillController = TextEditingController();

  void _addSkill(String skill) {
    if (skill.trim().isEmpty) return;
    if (_skills.contains(skill.trim())) return;
    setState(() {
      _skills.add(skill.trim());
    });
    _skillController.clear();
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  void _showAddSkillDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a Skill"),
        content: TextField(
          controller: _skillController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Enter a skill",
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            _addSkill(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addSkill(_skillController.text);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.skillForm,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ..._skills.map((skill) => Chip(
                    label: Text(skill),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => _removeSkill(skill),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                  GestureDetector(
                    onTap: _showAddSkillDialog,
                    child: DottedBorderContainer(),
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

class DottedBorderContainer extends StatelessWidget {
  const DottedBorderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "+ Add a Skill",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
