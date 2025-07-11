import 'package:flutter/material.dart';
import '../../features/resume/screens/widgets/model/selectable_item.dart';
import '../../features/resume/screens/widgets/selectable_item_bottom_sheet.dart';

void launchCategoryBottomSheet({
  required BuildContext context,
  required String title,
  required Map<String, List<SelectableItem>> categoryData,
  required List<String> initiallySelected,
  required int maxSelection,
  required Function(List<String>) onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => SelectableItemBottomSheet(
      title: title,
      categoryData: categoryData,
      initiallySelected: initiallySelected,
      maxSelection: maxSelection,
      onConfirm: onConfirm,
    ),
  );
}
