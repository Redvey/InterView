import 'package:flutter/material.dart';
import '../../../app/themes/text_styles.dart';

class FeatureContainer extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final String subTitle;
  final Color color;
  final Color colorBg;
  final IconData icon;

  const FeatureContainer({
    super.key,
    required this.gradient,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.colorBg,
    this.icon = Icons.brush_outlined,
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
            // Left Side Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: AppTextStyles.heading(color: color)),
                const SizedBox(height: 4),
                Text(subTitle, style: AppTextStyles.subheading(color: colorBg)),
              ],
            ),
            // Icon
            CircleAvatar(
              backgroundColor: Colors.white.withAlpha(26),
              child: ShaderMask(
                shaderCallback: (bounds) => gradient.createShader(bounds),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

