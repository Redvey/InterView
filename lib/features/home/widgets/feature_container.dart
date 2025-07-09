import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/themes/text_styles.dart';


class FeatureContainer extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final String subTitle;
  const FeatureContainer({
    super.key, required this.gradient, required this.title, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: gradient
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
                Text(title,style: AppTextStyles.heading,),
                Text(subTitle,style: AppTextStyles.subheading,),
              ],
            ),
            CircleAvatar(
              backgroundColor: AppColors.backgroundYellow,
            )
          ],
        ),
      ),
    );
  }
}