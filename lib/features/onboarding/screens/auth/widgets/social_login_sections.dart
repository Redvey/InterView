import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';


class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  });

  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.fifty,
      margin:  EdgeInsets.only(bottom: context.mxs),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: context.iconSizeMD,color: AppColors.blackLight,),
        label: Text(text,style: context.buttonSmallStyle.copyWith(color: AppColors.textGrey),),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.white,
          side: const BorderSide(color: AppColors.grey300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.md),
          ),
        ),
      ),
    );
  }
}
