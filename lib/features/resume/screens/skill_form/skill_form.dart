import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/resume/screens/skill_form/sheet/skill_selection_bottom_sheet.dart';
import 'package:interview/features/resume/screens/skill_form/widgets/skill_wrap.dart';

import 'controller/skills_controller.dart';


class SkillForm extends StatefulWidget {
  const SkillForm({super.key});

  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final SkillController _controller = SkillController();

  void _showSkillBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SkillSelectionBottomSheet(
        initiallySelected: _controller.skills,
        onConfirm: (selected) {
          setState(() {
            _controller.setSkills(selected);
          });
        },
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.skillForm,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SkillWrap(
              skills: _controller.skills,
              onDelete: (skill) => _controller.removeSkill(skill, () => setState(() {})),
              onAdd: _showSkillBottomSheet,
            ),
          ],
        ),
      ),
    );
  }
}
