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
  final bool newChild;
  final Widget child;

  // Navigation parameters - backward compatible
  final String? navigate;
  final String? routeName;
  final Map<String, String>? pathParams;
  final Map<String, dynamic>? extra;
  final Map<String, String>? routeParams;

  // Callback functions for button presses
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;

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
    this.onYesPressed,
    this.onNoPressed,
    this.newChild = false,
    this.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(context.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.borderRadiusLg),
        child:  Container(
          padding: EdgeInsets.all(context.lg),
          decoration: BoxDecoration(
            color: AppColors.blackLight,
            borderRadius: BorderRadius.circular(context.borderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple,
                blurRadius: context.welcomeBlur,
                offset: Offset(0, context.shadowOffsetY),
                spreadRadius: context.welcomeSpread,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glow effect container or custom icon
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
              // Conditional content
              if (newChild)
                child
              else ...[
                SizedBox(height: context.spaceBtwItems),
                Text(
                  title,
                  style: context.dialogBoxTitleStyle,
                  textAlign: TextAlign.center,
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
                        onPressed: () => _handleNoPressed(context),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.backgroundWhite,
                        ),
                        child: Text(no, style: context.yesStyle),
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
                      child: Text(yes, style: context.yesStyle),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _handleYesPressed(BuildContext context) {
    // If custom callback is provided, use it
    if (onYesPressed != null) {
      onYesPressed!();
      return;
    }

    // Otherwise, use the default navigation logic
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

  void _handleNoPressed(BuildContext context) {
    // If custom callback is provided, use it
    if (onNoPressed != null) {
      onNoPressed!();
      return;
    }

    // Otherwise, just close the dialog
    Navigator.pop(context);
  }
}