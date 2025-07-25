import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

class FinalStepDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String yes;
  final String no;
  final String? navigate;


  const FinalStepDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.yes,
    required this.no, required this.navigate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(context.lg),
      child: Container(
        padding: EdgeInsets.all(context.lg),
        decoration: BoxDecoration(
          color: AppColors.blackLight,
          borderRadius: BorderRadius.circular(context.borderRadiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withAlpha(1075),
              blurRadius: context.welcomeBlur,
              offset: Offset(0, context.shadowOffsetY),
              spreadRadius: context.welcomeSpread,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: context.glowW,
                height: context.glowH,
                decoration: BoxDecoration(
                  color: AppColors.otherForm,
                  borderRadius: BorderRadius.circular(context.glowH / 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple,
                      blurRadius: context.glowBlur,
                      offset: Offset(0, context.shadowOffsetY),
                      spreadRadius: context.glowSpread,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.spaceBtwItems),
             Text(
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              title,
            ),
            SizedBox(height: context.defaultSpace),
             Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: context.spaceBtwFields),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: Text(no),
                ),
                SizedBox(width: context.defaultSpace),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // ✅ Dismiss dialog
                    if (navigate != null) {
                      context.push(navigate!); // ✅ Navigate if a route is given
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.buttonRadius),
                    ),
                  ),
                  child: Text(yes),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
