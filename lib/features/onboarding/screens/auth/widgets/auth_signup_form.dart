import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/social_login_sections.dart';
import '../../../../../core/constants/colors.dart';
import 'auth_text_field.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';


class AuthSignupForm extends StatelessWidget {
  const AuthSignupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.agreeToTerms,
    required this.onToggleObscurePassword,
    required this.onToggleObscureConfirmPassword,
    required this.onToggleAgreeToTerms,
    required this.onSignup,
    required this.isLoading,
    required this.validateEmail,
    required this.validatePassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeToTerms;
  final VoidCallback onToggleObscurePassword;
  final VoidCallback onToggleObscureConfirmPassword;
  final ValueChanged<bool?> onToggleAgreeToTerms;
  final VoidCallback onSignup;
  final bool isLoading;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;

  Widget _buildPasswordRequirements(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.sm),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(color: AppColors.blue200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.passwordRequirements,
            style: context.infoSmallHeaderStyle,
          ),
          SizedBox(height: context.xs),
          _buildRequirementRow(context, 'At least 8 characters', isMet: true),
          _buildRequirementRow(context, 'One uppercase letter', isMet: true),
          _buildRequirementRow(context, 'One number', isMet: true),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(BuildContext context, String text, {required bool isMet}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: context.iconSizeSX, color: AppColors.blue600),
          SizedBox(width: context.sm),
          Text(
            text,
            style: context.hintTextGreyStyle.copyWith(
              fontSize: context.fontSizeSs,
              color: AppColors.blue700,
            ),
          ),
        ],
      ),
    );
  }

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
              AppStrings.joinUsToday,
              style: context.welcomeStyle,
            ),
            SizedBox(height: context.spaceLess),
            Text(
              AppStrings.createAccountAndGetStarted,
              style: context.hintTextGreyStyle,
            ),
            SizedBox(height: context.spaceBtwSections),

            // Social Signup Buttons
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

            // Name Field
            AuthTextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              labelText: AppStrings.fullName,
              hintText: AppStrings.enterYourFullName,
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value?.isEmpty ?? true) return AppStrings.pleaseEnterYourName;
                if (value!.length < 2) {
                  return AppStrings.nameTooShort;
                }
                return null;
              },
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
              hintText: AppStrings.createStrongPassword,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: onToggleObscurePassword,
              ),
              validator: validatePassword,
            ),

            SizedBox(height: context.spaceBtwItems),

            // Confirm Password Field
            AuthTextField(
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              labelText: AppStrings.confirmPassword,
              hintText: AppStrings.reEnterYourPassword,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: onToggleObscureConfirmPassword,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return AppStrings.pleaseConfirmPassword;
                }
                if (value != passwordController.text) {
                  return AppStrings.passwordsDoNotMatch;
                }
                return null;
              },
              onFieldSubmitted: (_) => onSignup(),
            ),

            SizedBox(height: context.spaceBtwItems),

            // Password Requirements
            _buildPasswordRequirements(context),

            SizedBox(height: context.spaceBtwItems),

            // Terms and Conditions Checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: agreeToTerms,
                  onChanged: onToggleAgreeToTerms,
                  activeColor: AppColors.blue600,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onToggleAgreeToTerms(!agreeToTerms),
                    child: Text.rich(
                      TextSpan(
                        style: context.hintTextGreyStyle,
                        children: [
                           TextSpan(text: AppStrings.termsAndConditionsPart1,style: context.hintTextColorful(color: AppColors.textGrey)),
                          TextSpan(
                            text: AppStrings.termsAndConditionsPart2,
                            style: context.hintTextColorful(color: AppColors.buttonTextBlue).copyWith(fontWeight: FontWeight.w600),
                          ),
                           TextSpan(text: AppStrings.termsAndConditionsPart3,style: context.hintTextColorful(color: AppColors.textGrey)),
                          TextSpan(
                            text: AppStrings.termsAndConditionsPart4,
                            style: context.hintTextColorful(color: AppColors.buttonTextBlue).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: context.spaceBtwItems),

            // Signup Button
            SizedBox(
              width: double.infinity,
              height: context.circularButtonSize,
              child: ElevatedButton(
                onPressed: (!agreeToTerms || isLoading) ? null : onSignup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blackLight,
                  disabledBackgroundColor: AppColors.grey300,
                  elevation: context.buttonElevation,
                  shadowColor: AppColors.blue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.radiusLG),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text(
                  AppStrings.createAccount,
                  style: context.buttonWhiteTextStyle.copyWith(
                    fontSize: context.fontSizeSd,
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
