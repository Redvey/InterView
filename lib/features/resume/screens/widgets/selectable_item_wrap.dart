import 'package:flutter/material.dart';
import '../../widgets/dotted_button.dart';
import 'deletable_item_chip.dart';

class SelectableItemWrap extends StatelessWidget {
  final List<String> selectedItems;
  final void Function(String item) onDelete;
  final VoidCallback onAdd;
  final String addLabel;

  const SelectableItemWrap({
    super.key,
    required this.selectedItems,
    required this.onDelete,
    required this.onAdd,
    this.addLabel = " Add Item",
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...selectedItems.map(
                (item) => DeletableItemChip(
              label: item,
              onDeleted: () => onDelete(item),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: DottedBorderButton(detail: addLabel),
          ),
        ],
      ),
    );
  }
}
