import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../app/themes/text_styles.dart';
import '../../../../../core/constants/colors.dart';

class DurationSelectionWidget extends StatelessWidget {
  final String selectedDuration;
  final List<String> durations;
  final ValueChanged<String> onDurationChanged;

  const DurationSelectionWidget({
    super.key,
    required this.selectedDuration,
    required this.durations,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.sm,
      children: durations.map((duration) {
        final isSelected = selectedDuration == duration;
        return ChoiceChip(
          label: Text(duration),
          selected: isSelected,
          onSelected: (_) => onDurationChanged(duration),
          selectedColor: AppColors.blackLight,
          labelStyle: isSelected
              ? AppTextStyles.chipSelected(context)
              : AppTextStyles.chipUnselected(context),
          backgroundColor: AppColors.white,
          shape: StadiumBorder(
            side: BorderSide(color: AppColors.grey400),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}