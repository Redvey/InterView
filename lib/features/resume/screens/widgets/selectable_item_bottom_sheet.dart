import 'package:flutter/material.dart';

import 'model/selectable_item.dart';



/// Generic bottom sheet widget
class SelectableItemBottomSheet extends StatefulWidget {
  final String title;
  final Map<String, List<SelectableItem>> categoryData;
  final List<String> initiallySelected;
  final int maxSelection;
  final Function(List<String>) onConfirm;


  final Color? sheetColor;
  const SelectableItemBottomSheet({
    super.key,
    required this.title,
    required this.categoryData,
    required this.initiallySelected,
    required this.maxSelection,
    required this.onConfirm,
    this.sheetColor,
  });

  @override
  State<SelectableItemBottomSheet> createState() => _SelectableItemBottomSheetState();
}

class _SelectableItemBottomSheetState extends State<SelectableItemBottomSheet> {
  late final Map<String, List<SelectableItem>> _items;

  @override
  void initState() {
    super.initState();
    _items = _deepClone(widget.categoryData);
    _preselectItems();
  }

  Map<String, List<SelectableItem>> _deepClone(Map<String, List<SelectableItem>> original) {
    return {
      for (var entry in original.entries)
        entry.key: entry.value.map((item) => item.clone()).toList(),
    };
  }

  void _preselectItems() {
    for (var item in _items.values.expand((e) => e)) {
      if (widget.initiallySelected.contains(item.name)) {
        item.isSelected = true;
      }
    }
  }

  List<SelectableItem> get _selectedItems =>
      _items.values.expand((e) => e).where((s) => s.isSelected).toList();

  void _toggleItem(SelectableItem item) {
    setState(() {
      item.isSelected = !item.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedItems.length;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration:  BoxDecoration(
        color: widget.sheetColor ?? Colors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.title} ($selectedCount / ${widget.maxSelection})",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  final selected = _selectedItems.map((s) => s.name).toList();
                  widget.onConfirm(selected);
                  Navigator.pop(context);
                },
                child: const Icon(Icons.check),
              )
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: _items.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.key, style: Theme.of(context).textTheme.titleMedium),
                    Wrap(
                      spacing: 8,
                      children: entry.value.map((item) {
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
                            if (!isSelected && selectedCount >= widget.maxSelection) return;
                            _toggleItem(item);
                          },
                          selectedColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
