

import 'package:flutter/material.dart';
import 'package:interview/features/widgets/selectable_item_chip.dart';
import 'package:interview/features/resume/screens/widgets/model/selectable_item.dart';

class CategoryTab extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableItemChip.preference(
      item: SelectableItem(
        name: category,
        isSelected: isSelected,
        icon: Icons.category, // or null if no icon
      ),
      selectedCount: isSelected ? 1 : 0,
      maxSelection: 1,
      onToggle: (_) => onTap(),
      showIcon: false,
    );
  }
}
