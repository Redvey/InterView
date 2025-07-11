import 'package:flutter/material.dart';
import '../model/skill_item.dart';

class SelectableSkillChip extends StatelessWidget {
  final SkillItem skill;
  final int selectedCount;
  final int maxSelection;
  final Function(SkillItem) onToggle;

  const SelectableSkillChip({
    super.key,
    required this.skill,
    required this.selectedCount,
    required this.maxSelection,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = skill.isSelected;

    return ChoiceChip(
      label: Text(skill.name),
      avatar: Icon(
        skill.icon,
        size: 18,
        color: isSelected ? Colors.white : Colors.black,
      ),
      selected: isSelected,
      onSelected: (_) {
        if (!isSelected && selectedCount >= maxSelection) return;
        onToggle(skill);
      },
      selectedColor: Colors.black,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      showCheckmark: false,
    );
  }
}
