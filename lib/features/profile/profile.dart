import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/widgets/back_button.dart';

import '../../core/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.blackLight),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.all(AppSizes.lg),
            child: Row(
              children: [
                CircleBackButton(pageColor: AppColors.blackLight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}



