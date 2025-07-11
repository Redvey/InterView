import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import '../../../app/themes/text_styles.dart';

class FeatureContainer extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final String subTitle;
  final Color color;
  final Color colorBg;

  const FeatureContainer({
    super.key,
    required this.gradient,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.colorBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: gradient,
      ),
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading(color: color)),
                Text(subTitle, style: AppTextStyles.subheading(color: colorBg)),
              ],
            ),
            CircleAvatar(
              backgroundColor: AppColors.backgroundYellow,
              child: ShaderMask(
                shaderCallback: (bounds) => gradient.createShader(bounds),
                child: const Icon(
                  Icons.brush_outlined,
                  size: 32,
                  color: Colors.white, // Must be white to reveal gradient
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
