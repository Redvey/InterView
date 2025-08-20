import 'package:flutter/material.dart';
import 'model/selectable_item.dart';
import '../../../widgets/selectable_item_chip.dart';

class SelectableItemListView extends StatelessWidget {
  final Map<String, List<SelectableItem>> items;
  final int selectedCount;
  final int maxSelection;
  final Function(SelectableItem) onToggle;

  const SelectableItemListView({
    super.key,
    required this.items,
    required this.selectedCount,
    required this.maxSelection,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.entries.map((entry) {
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
              children: entry.value.map((item) {
                return SelectableItemChip(
                  item: item,
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
