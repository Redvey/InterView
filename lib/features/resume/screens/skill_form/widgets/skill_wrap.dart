import 'package:flutter/material.dart';
import '../../../widgets/dotted_button.dart';
import 'deletable_skill_chip.dart';

class SkillWrap extends StatelessWidget {
  final List<String> skills;
  final void Function(String skill) onDelete;
  final VoidCallback onAdd;

  const SkillWrap({
    super.key,
    required this.skills,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...skills.map(
                (skill) => DeletableSkillChip(
              label: skill,
              onDeleted: () => onDelete(skill),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: const DottedBorderButton(detail: ' Add Skill'),
          ),
        ],
      ),
    );
  }
}
