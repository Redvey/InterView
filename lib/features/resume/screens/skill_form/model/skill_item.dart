import 'package:flutter/material.dart';

class SkillItem {
  final String name;
  final IconData icon;
  bool isSelected;

  SkillItem({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
}
