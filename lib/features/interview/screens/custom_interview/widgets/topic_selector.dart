import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../app/themes/text_styles.dart';
import '../../../../../core/constants/colors.dart';

class TopicsSelectionWidget extends StatelessWidget {
  final List<String> availableTopics;
  final Set<String> selectedTopics;
  final ValueChanged<Set<String>> onTopicsChanged;

  const TopicsSelectionWidget({
    super.key,
    required this.availableTopics,
    required this.selectedTopics,
    required this.onTopicsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing:  context.sm,
      runSpacing:  context.xs,
      children: availableTopics.map((topic) {
        final isSelected = selectedTopics.contains(topic);
        return FilterChip(
          label: Text(topic),
          selected: isSelected,
          onSelected: (selected) {
            final newSelectedTopics = Set<String>.from(selectedTopics);
            if (selected) {
              newSelectedTopics.add(topic);
            } else {
              newSelectedTopics.remove(topic);
            }
            onTopicsChanged(newSelectedTopics);
          },
          selectedColor: AppColors.textGreenWithAlpha51,
          checkmarkColor: AppColors.backgroundGreen,
          labelStyle: isSelected
              ? AppTextStyles.filterChipSelected(context)
              : AppTextStyles.filterChipUnselected(context),
        );
      }).toList(),
    );
  }
}