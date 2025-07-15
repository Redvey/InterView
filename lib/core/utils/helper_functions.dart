import 'package:flutter/material.dart';
import '../../features/home/widgets/feature_container.dart';
import '../../features/resume/screens/widgets/model/selectable_item.dart';
import '../../features/resume/screens/widgets/selectable_item_bottom_sheet.dart';
import '../constants/sizes.dart';

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

Widget featureListItem({
  required BuildContext context,
  required VoidCallback onTap,
  required Gradient gradient,
  required String title,
  required String subTitle,
  required Color color,
  required Color colorBg,
  IconData icon = Icons.brush_outlined,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: FeatureContainer(
          gradient: gradient,
          title: title,
          subTitle: subTitle,
          color: color,
          colorBg: colorBg,
          icon: icon,
        ),
      ),
      SizedBox(height: AppSizes.defaultSpace),
    ],
  );
}
