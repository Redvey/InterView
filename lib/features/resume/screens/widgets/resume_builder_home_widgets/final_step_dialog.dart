import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';

class FinalStepDialog extends StatelessWidget {
  const FinalStepDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(AppSizes.lg),
      child: Container(
        padding: EdgeInsets.all(AppSizes.lg),
        decoration: BoxDecoration(
          color: AppColors.blackLight,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withAlpha(1075),
              blurRadius: AppSizes.welcomeBlur,
              offset: Offset(0, AppSizes.shadowOffsetY),
              spreadRadius: AppSizes.welcomeSpread,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: AppSizes.glowW,
                height: AppSizes.glowH,
                decoration: BoxDecoration(
                  color: AppColors.otherForm,
                  borderRadius: BorderRadius.circular(AppSizes.glowH / 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple,
                      blurRadius: AppSizes.glowBlur,
                      offset: Offset(0, AppSizes.shadowOffsetY),
                      spreadRadius: AppSizes.glowSpread,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            const Text(
              "Final Step",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.defaultSpace),
            const Text(
              "Have you filled in all your details correctly?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwFields),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text("No"),
                ),
                SizedBox(width: AppSizes.defaultSpace),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.push('/final');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                    ),
                  ),
                  child: const Text("Yes, Proceed"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
