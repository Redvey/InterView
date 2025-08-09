import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../core/constants/colors.dart';

class ErrorScreen extends StatelessWidget {
  final String? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: context.lgA,
                  color: AppColors.error,
                ),
                SizedBox(height: context.xxl), // 24
                Text(
                  'Oops! Something went wrong',
                  style: context.headingStyle(color: AppColors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.spaceBtwItemsH), // 16
                if (error != null)
                  Text(
                    error!,
                    style: context.subheadingStyle(color: AppColors.textGrey),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: context.recentSearches), // 40
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue600,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.xxxl, // 32
                      vertical: context.spaceBtwItemsH, // 16
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.radiusMD), // 12
                    ),
                  ),
                  child: Text('Go Home', style: context.buttonWhiteTextStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}