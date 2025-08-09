import 'package:flutter/material.dart';

import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/auth_action_buttons.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/auth_branding.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/login_bottom_sheet.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/social_login_sections.dart';
import '../../../../core/constants/colors.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void _showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.lg),
          child: Column(
            children: [
              const Spacer(),
              const AuthBranding(),
              const Spacer(),
              AuthActionButtons(
                onSignInPressed: () => _showLoginBottomSheet(context),
              ),
              SizedBox(height: context.lg),
              const SocialLoginSection(),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: context.spaceBtwFields),
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  style: context.hintTextStyle(color: AppColors.textGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}