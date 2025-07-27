import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../app/themes/text_styles.dart';
import '../../../../../core/constants/colors.dart';


class DifficultySelectionWidget extends StatelessWidget {
  final String selectedDifficulty;
  final List<String> difficulties;
  final ValueChanged<String> onDifficultyChanged;

  const DifficultySelectionWidget({
    super.key,
    required this.selectedDifficulty,
    required this.difficulties,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing:  context.sm,
      children: difficulties.map((difficulty) {
        final isSelected = selectedDifficulty == difficulty;
        return ChoiceChip(
          label: Text(difficulty),
          selected: isSelected,
          onSelected: (_) => onDifficultyChanged(difficulty),
          selectedColor: AppColors.blackLight,
          labelStyle: isSelected
              ? AppTextStyles.chipSelected(context)
              : AppTextStyles.chipUnselected(context),
          backgroundColor: AppColors.backgroundWhite,
          shape: StadiumBorder(
            side: BorderSide(color: AppColors.textGrey),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}