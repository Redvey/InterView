import 'package:flutter/material.dart';
import 'package:interview/features/widgets/selectable_item_chip.dart';
import 'package:interview/features/resume/screens/widgets/model/selectable_item.dart';

/// A simple wrapper widget for creating a skill chip using SelectableItemChip.
/// It simplifies the API by exposing only the necessary properties.
class SkillChip extends StatelessWidget {
  final String skill;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillChip({
    super.key,
    required this.skill,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableItemChip.skill(
      item: SelectableItem(
        name: skill,
        isSelected: isSelected,
        icon: Icons.star_outline, // Changed to a more skill-appropriate icon
      ),
      selectedCount: isSelected ? 1 : 0,
      maxSelection: 1,
      onToggle: (_) => onTap(),
      showIcon: false,
    );
  }
}