import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/services/auth_service.dart';

import '../../../../../core/constants/colors.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await AuthService.login(_emailController.text, _passwordController.text);
      if (mounted) {
        Navigator.pop(context);
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleForgotPassword() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: const Text('Password reset functionality will be implemented soon.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context, {required String label, required IconData icon, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(context.radiusMD)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: BorderSide(color: AppColors.blue600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.radiusLG)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: context.lg,
        right: context.lg,
        top: context.spaceBtwFields,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.handleWidth,
            height: context.handleHeight,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(context.radiusXS),
            ),
          ),
          SizedBox(height: context.lg),
          Text('Welcome Back', style: context.headingStyle(color: AppColors.black87)),
          SizedBox(height: context.sm),
          Text('Sign in to your account', style: context.subheadingStyle(color: AppColors.textGrey)),
          SizedBox(height: context.lg),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration(context, label: 'Email', icon: Icons.email_outlined),
                  validator: (v) => (v?.isEmpty ?? true) || !v!.contains('@') ? 'Please enter a valid email' : null,
                ),
                SizedBox(height: context.spaceBtwFields),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: _buildInputDecoration(
                    context,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) => (v?.isEmpty ?? true) ? 'Please enter your password' : null,
                ),
                SizedBox(height: context.lg),
                SizedBox(
                  width: double.infinity,
                  height: context.createButtonHeight,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue600,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.white))
                        : Text('Sign In', style: context.buttonWhiteTextStyle),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.sm),
          TextButton(
            onPressed: _handleForgotPassword,
            child: Text('Forgot Password?', style: context.buttonTextStyle.copyWith(color: AppColors.blue600)),
          ),
          SizedBox(height: context.lg),
        ],
      ),
    );
  }
}