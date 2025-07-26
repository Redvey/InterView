// File: lib/features/interview/widgets/difficulty_chip.dart

import 'package:flutter/material.dart';
import 'package:interview/features/interview/widgets/interview_card.dart';

import '../../../app/themes/fonts.dart';

class DifficultyChip extends StatelessWidget {
  final DifficultyLevel difficulty;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final double? fontSize;

  const DifficultyChip({
    super.key,
    required this.difficulty,
    this.isSelected = false,
    this.onSelected,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        difficulty.displayName,
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: fontSize ?? 12,
          fontWeight: FontWeight.w500,
          color: isSelected
              ? Colors.white
              : difficulty.color,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: difficulty.color,
      backgroundColor: Colors.transparent,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: difficulty.color,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      showCheckmark: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}