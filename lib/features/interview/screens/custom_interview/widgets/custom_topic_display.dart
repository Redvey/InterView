import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../app/themes/text_styles.dart';
import '../../../../../core/constants/colors.dart';



class CustomTopicsDisplayWidget extends StatelessWidget {
  final List<String> customTopics;
  final ValueChanged<String> onRemoveTopic;

  const CustomTopicsDisplayWidget({
    super.key,
    required this.customTopics,
    required this.onRemoveTopic,
  });

  @override
  Widget build(BuildContext context) {
    if (customTopics.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
         SizedBox(height:  context.sm),
        Wrap(
          spacing:  context.sm,
          runSpacing:  context.xs,
          children: customTopics.map((topic) {
            return Chip(
              label: Text(topic),
              deleteIcon: Icon(
                Icons.close,
                size: context.iconSizeSM,
              ),
              onDeleted: () => onRemoveTopic(topic),
              backgroundColor: AppColors.textGreenWithAlpha26,
              labelStyle: AppTextStyles.customChipText(context),
            );
          }).toList(),
        ),
      ],
    );
  }
}