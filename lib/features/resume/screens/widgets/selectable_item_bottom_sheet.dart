import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'model/selectable_item.dart';
import '../../../widgets/selectable_item_chip.dart';

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
      height: context.screenHeight * 0.85,
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: widget.sheetColor ?? Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.radiusXL),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.paddingMD),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.title} ($selectedCount / ${widget.maxSelection})",
                  style: TextStyle(
                    fontSize: context.fontSizeSm,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final selected = _selectedItems.map((s) => s.name).toList();
                    widget.onConfirm(selected);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.check, size: context.iconSizeMD),
                ),
              ],
            ),
          ),
          SizedBox(height: context.spaceBtwFields),
          Expanded(
            child: ListView(
              children: _items.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      spacing: context.paddingSM,
                      children: entry.value.map((item) {
                        return SelectableItemChip.skill(
                          item: item,
                          selectedCount: selectedCount,
                          maxSelection: widget.maxSelection,
                          onToggle: _toggleItem,
                          showIcon: true,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: context.spaceBtwFields),
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