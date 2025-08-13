import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/social_login_sections.dart';
import '../../../../../core/constants/colors.dart';
import 'auth_text_field.dart';


class AuthLoginForm extends StatelessWidget {
  const AuthLoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.onLogin,
    required this.isLoading,
    required this.validateEmail,
    required this.validatePassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final VoidCallback onLogin;
  final bool isLoading;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.md),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.welcomeBack,
              style: context.buttonTextStyle,
            ),
            SizedBox(height: context.spaceLess),
            Text(
              AppStrings.signInToContinue,
              style: context.hintTextGreyStyle,
            ),
            SizedBox(height: context.spaceBtwSections),

            // Social Login Buttons
            AuthSocialButton(
              text: AppStrings.continueWithGoogle,
              icon: Icons.g_mobiledata,
              onPressed: () {},
            ),
            AuthSocialButton(
              text: AppStrings.continueWithApple,
              icon: Icons.apple,
              onPressed: () {},
            ),

            SizedBox(height: context.spaceBtwItems),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.grey300)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.sm),
                  child: Text(AppStrings.or, style: context.hintTextGreyStyle),
                ),
                Expanded(child: Divider(color: AppColors.grey300)),
              ],
            ),

            SizedBox(height: context.spaceBtwItems),

            // Email Field
            AuthTextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              labelText: AppStrings.emailAddress,
              hintText: AppStrings.enterYourEmail,
              prefixIcon: Icons.email_outlined,
              validator: validateEmail,
            ),

            SizedBox(height: context.spaceBtwItems),

            // Password Field
            AuthTextField(
              controller: passwordController,
              obscureText: obscurePassword,
              labelText: AppStrings.password,
              hintText: AppStrings.enterYourPassword,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: onToggleObscure,
              ),
              validator: validatePassword,
              onFieldSubmitted: (_) => onLogin(),
            ),

            SizedBox(height: context.sm),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.forgotPassword,
                  style: context.buttonSmallStyle,
                ),
              ),
            ),

            SizedBox(height: context.spaceBtwItems),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: context.circularButtonSize,
              child: ElevatedButton(
                onPressed: isLoading ? null : onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blackLight,
                  disabledBackgroundColor: AppColors.grey300,
                  elevation: context.buttonElevation,
                  shadowColor: AppColors.bottomBlackLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.radiusLG),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text(
                  AppStrings.signIn,
                  style: context.buttonWhiteTextStyle.copyWith(
                    fontSize: context.fontSizeSx,
                  ),
                ),
              ),
            ),

            SizedBox(height: context.spaceBtwSections),

            // Guest Mode
            Center(
              child: TextButton(
                onPressed: () => context.go('/profile-setup'),
                child: Text(
                  AppStrings.continueAsGuest,
                  style: context.hintTextGreyStyle.copyWith(
                   fontSize: context.fontSizeSm,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            SizedBox(height: context.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
