import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

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
        borderRadius: BorderRadius.circular( context.borderRadiusLg ),
        gradient: gradient,
      ),
      height:  context.featureCard ,
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.all( context.md ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: context.headingStyle(color: color)),
                 SizedBox(height:  context.headSubhead ),
                Text(subTitle, style: context.subheadingStyle(color: colorBg )),
              ],
            ),
            // Icon
            CircleAvatar(
              backgroundColor: AppColors.cardOverlay,
              child: ShaderMask(
                shaderCallback: (bounds) => gradient.createShader(bounds),
                child: Icon(
                  Icons.auto_fix_high,
                  size:  context.iconSizeSm ,
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

