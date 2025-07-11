import 'package:flutter/material.dart';
import '../model/skill_item.dart';
import '../widgets/skill_chip.dart';

class SkillListView extends StatelessWidget {
  final Map<String, List<SkillItem>> skills;
  final int selectedCount;
  final int maxSelection;
  final Function(SkillItem) onToggle;

  const SkillListView({
    super.key,
    required this.skills,
    required this.selectedCount,
    required this.maxSelection,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: skills.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.key,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entry.value.map((skill) {
                return SelectableSkillChip(
                  skill: skill,
                  selectedCount: selectedCount,
                  maxSelection: maxSelection,
                  onToggle: onToggle,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
