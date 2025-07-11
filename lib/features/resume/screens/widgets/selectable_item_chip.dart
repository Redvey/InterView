import 'package:flutter/material.dart';

import 'model/selectable_item.dart';


class SelectableItemChip extends StatelessWidget {
  final SelectableItem item;
  final int selectedCount;
  final int maxSelection;
  final Function(SelectableItem) onToggle;

  const SelectableItemChip({
    super.key,
    required this.item,
    required this.selectedCount,
    required this.maxSelection,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = item.isSelected;

    return ChoiceChip(
      label: Text(item.name),
      avatar: Icon(
        item.icon,
        size: 18,
        color: isSelected ? Colors.white : Colors.black,
      ),
      selected: isSelected,
      onSelected: (_) {
        if (!isSelected && selectedCount >= maxSelection) return;
        onToggle(item);
      },
      selectedColor: Colors.black,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      showCheckmark: false,
    );
  }
}
