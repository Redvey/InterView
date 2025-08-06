import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';



class FlashCardsHistoryScreen extends StatelessWidget {
  const FlashCardsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: context.defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction),
          Text(
            AppStrings.underConstruction,
            style: context.headingStyle(color: AppColors.bottomBlack),
          ),
        ],
      ),
    );
  }
}