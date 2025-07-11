import 'package:flutter/material.dart';

class SkillBottomSheetHeader extends StatelessWidget {
  final int selectedCount;
  final int maxSelection;
  final VoidCallback onConfirm;

  const SkillBottomSheetHeader({
    super.key,
    required this.selectedCount,
    required this.maxSelection,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Skills ($selectedCount / $maxSelection)",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
