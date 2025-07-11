import 'package:flutter/material.dart';

class SelectableItem {
  final String name;
  final IconData icon;
  bool isSelected;

  SelectableItem({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });


  SelectableItem clone() {
    return SelectableItem(
      name: name,
      icon: icon,
      isSelected: isSelected,
    );
  }
}
