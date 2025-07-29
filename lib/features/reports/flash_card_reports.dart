import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../core/constants/colors.dart';



class FlashCardsHistoryScreen extends StatelessWidget {
  const FlashCardsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FlashCard History', style: context.welcomeStyle),
          SizedBox(height: context.spaceBtwSections),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.bottomBlackLight,
              borderRadius: BorderRadius.circular(context.borderRadiusLg),
            ),
            child: Center(
              child: Text(
                'FlashCard History Content',
                style: context.welcomeStyle.copyWith(
                  color: AppColors.backgroundYellow,
                ),
              ),
            ),
          ),
          SizedBox(height: context.bottomNavHeight + 20),
        ],
      ),
    );
  }
}