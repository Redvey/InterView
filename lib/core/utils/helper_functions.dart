import 'package:flutter/material.dart';
import 'package:interview/features/resume/screens/skill_form/widgets/skill_chip.dart';

import '../../features/resume/screens/skill_form/sheet/skill_selection_bottom_sheet.dart';

void launchCategoryBottomSheet({
  required BuildContext context,
  required String title,
  required Map<String, List<SelectableSkillChip>> categoryData,
  required List<String> initiallySelected,
  required int maxSelection,
  required Function(List<String>) onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => SkillSelectionBottomSheet(

      initiallySelected: initiallySelected,
      maxSelection: maxSelection,
      onConfirm: onConfirm,
    ),
  );
}
