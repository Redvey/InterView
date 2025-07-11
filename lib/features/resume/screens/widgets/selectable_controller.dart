import 'package:flutter/material.dart';

class GenericSelectableController {
  List<String> selectedItems = [];
  final TextEditingController inputController = TextEditingController();

  void addItem(String item, VoidCallback refresh, {int? max}) {
    final trimmed = item.trim();
    if (trimmed.isEmpty || selectedItems.contains(trimmed)) return;
    if (max != null && selectedItems.length >= max) return;
    selectedItems.add(trimmed);
    refresh();
    inputController.clear();
  }

  void removeItem(String item, VoidCallback refresh) {
    selectedItems.remove(item);
    refresh();
  }

  void setItems(List<String> newItems) {
    selectedItems = newItems;
    inputController.clear();
  }

  bool isSelected(String item) => selectedItems.contains(item);

  void toggleItem(String item, VoidCallback refresh, {int? max}) {
    if (isSelected(item)) {
      removeItem(item, refresh);
    } else {
      if (max != null && selectedItems.length >= max) return;
      selectedItems.add(item);
      refresh();
    }
  }

  void clear() {
    selectedItems.clear();
    inputController.clear();
  }
}
