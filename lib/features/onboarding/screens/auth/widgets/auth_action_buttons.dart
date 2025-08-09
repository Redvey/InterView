import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../core/constants/colors.dart';

class AuthActionButtons extends StatelessWidget {
  final VoidCallback onSignInPressed;

  const AuthActionButtons({
    super.key,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: context.createButtonHeight,
          child: ElevatedButton(
            onPressed: () => context.push('/signup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue600,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
            ),
            child: Text('Create Account', style: context.buttonWhiteTextStyle),
          ),
        ),
        SizedBox(height: context.spaceBtwItemsH),
        SizedBox(
          width: double.infinity,
          height: context.createButtonHeight,
          child: OutlinedButton(
            onPressed: onSignInPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.blue600, width: context.borderWidthDefault),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
            ),
            child: Text(
              'Sign In',
              style: context.buttonTextStyle.copyWith(color: AppColors.blue600),
            ),
          ),
        ),
      ],
    );
  }
}