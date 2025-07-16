import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
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
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        gradient: gradient,
      ),
      height: AppSizes.featureCard,
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.all(AppSizes.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: AppTextStyles.heading(color: color)),
                 SizedBox(height: AppSizes.headSubhead),
                Text(subTitle, style: AppTextStyles.subheading(color: colorBg)),
              ],
            ),
            // Icon
            CircleAvatar(
              backgroundColor: AppColors.cardOverlay,
              child: ShaderMask(
                shaderCallback: (bounds) => gradient.createShader(bounds),
                child: Icon(
                  icon,
                  size: AppSizes.iconSize,
                  color: AppColors.backgroundWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

