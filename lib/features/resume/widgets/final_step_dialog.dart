import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class FinalStepDialog extends StatelessWidget {
  final Map<String, String>? routeParams;

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
    required this.no,
    required this.navigate,
    this.routeParams,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(context.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular( context.borderRadiusLg),
        child: Container(
          padding: EdgeInsets.all(context.lg),
          decoration: BoxDecoration(
            color: AppColors.blackLight,
            borderRadius: BorderRadius.circular(context.borderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withAlpha(107),
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
                    borderRadius: BorderRadius.circular(context.glowBorderRadius),
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
                style: AppTextStyles.dialogBoxTitle(context),
                title,
              ),
              SizedBox(height: context.defaultSpace),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.dialogBoxSubTitle(context),
              ),
              SizedBox(height: context.spaceBtwFields),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(foregroundColor: AppColors.backgroundWhite),
                    child: Text(no,style: AppTextStyles.yes(context)),
                  ),
                  SizedBox(width: context.defaultSpace),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (navigate != null) {
                        context.pushNamed(navigate!, extra: routeParams ?? {});
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: AppColors.backgroundWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.buttonRadius),
                      ),
                    ),
                    child: Text(yes,style: AppTextStyles.yes(context)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
