import 'package:flutter/material.dart';

class DeletableSkillChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const DeletableSkillChip({
    super.key,
    required this.label,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      onDeleted: onDeleted,
      deleteIcon: const Icon(Icons.close),
      backgroundColor: Colors.grey[200],
    );
  }
}
