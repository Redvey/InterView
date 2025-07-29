import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/home/widgets/feature_container.dart';


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
      SizedBox(height: context.defaultSpaceH),
    ],
  );
}
