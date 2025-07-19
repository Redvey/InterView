import 'package:flutter/material.dart';

import '../../../core/utils/helper_functions.dart';

class FeatureListItem extends StatelessWidget {
  final VoidCallback onTap;
  final Gradient gradient;
  final String title;
  final String subTitle;
  final Color color;
  final Color colorBg;

  const FeatureListItem({
    super.key,
    required this.onTap,
    required this.gradient,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.colorBg,
  });

  @override
  Widget build(BuildContext context) {
    return featureListItem(
      context: context,
      onTap: onTap,
      gradient: gradient,
      title: title,
      subTitle: subTitle,
      color: color,
      colorBg: colorBg,
    );
  }
}