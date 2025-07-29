import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class FinalStepDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String yes;
  final String no;

  // Navigation parameters - backward compatible
  final String? navigate;
  final String? routeName;
  final Map<String, String>? pathParams;
  final Map<String, dynamic>? extra;
  final Map<String, String>? routeParams; 

  const FinalStepDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.yes,
    required this.no,
    this.navigate, 
    this.routeName,
    this.pathParams,
    this.extra,
    this.routeParams, 
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(context.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.borderRadiusLg),
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
              // Glow effect container
              Container(
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
              SizedBox(height: context.spaceBtwItems),
              Text(
                title,
                style: AppTextStyles.dialogBoxTitle(context),
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
                  if (no.isNotEmpty) ...[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.backgroundWhite,
                      ),
                      child: Text(no, style: AppTextStyles.yes(context)),
                    ),
                    SizedBox(width: context.defaultSpace),
                  ],
                  ElevatedButton(
                    onPressed: () => _handleYesPressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: AppColors.backgroundWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.buttonRadius),
                      ),
                    ),
                    child: Text(yes, style: AppTextStyles.yes(context)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleYesPressed(BuildContext context) {
    Navigator.pop(context);

    // Handle navigation - prioritize routeName, fallback to navigate
    if (routeName != null) {
      context.pushNamed(
        routeName!,
        pathParameters: pathParams ?? {},
        extra: extra ?? routeParams,
      );
    } else if (navigate != null) {
      context.push(navigate!, extra: routeParams ?? {});
    }
  }
}