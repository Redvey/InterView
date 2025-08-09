import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../core/constants/colors.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  void _handleSocialLogin(String provider) {
    // Implement social login logic
    print('Social login with $provider');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.grey300)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spaceBtwItems),
              child: Text('or', style: context.bodyBoldStyle.copyWith(color: AppColors.textGrey)),
            ),
            Expanded(child: Divider(color: AppColors.grey300)),
          ],
        ),
        SizedBox(height: context.spaceBtwFields),
        Row(
          children: [
            Expanded(
              child: _SocialLoginButton(
                icon: Icons.g_mobiledata, // Replace with a proper Google icon if available
                label: 'Google',
                onTap: () => _handleSocialLogin('google'),
              ),
            ),
            SizedBox(width: context.defaultSpace),
            Expanded(
              child: _SocialLoginButton(
                icon: Icons.apple,
                label: 'Apple',
                onTap: () => _handleSocialLogin('apple'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialLoginButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.radiusMD),
      child: Container(
        height: context.createButtonHeight,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey300),
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: context.iconSizeSm),
            SizedBox(width: context.sm),
            Text(label, style: context.buttonSmallStyle),
          ],
        ),
      ),
    );
  }
}