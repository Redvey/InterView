import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/signup/widgets/signin_redirect.dart';
import 'package:interview/features/onboarding/screens/signup/widgets/terms_conditions.dart';
import '../../../../../core/constants/colors.dart';
import 'password_requirements.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration({
    required BuildContext context,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    final borderRadius = BorderRadius.circular(context.radiusMD);
    final borderSide = BorderSide(color: AppColors.grey300);
    final focusedBorderSide = BorderSide(color: AppColors.blue600);
    final errorBorderSide = const BorderSide(color: AppColors.red);

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: borderRadius),
      enabledBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: borderSide),
      focusedBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: focusedBorderSide),
      errorBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: errorBorderSide),
    );
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      _showSnackBar('Please agree to the Terms of Service and Privacy Policy', AppColors.red);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final signupData = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      if (mounted) context.push('/profile-setup', extra: signupData);
    } catch (e) {
      if (mounted) _showSnackBar('Sign up failed: ${e.toString()}', AppColors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusMD)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _buildInputDecoration(
              context: context,
              labelText: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Please enter your email';
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value!)) return 'Please enter a valid email address';
              return null;
            },
          ),
          SizedBox(height: context.spaceBtwFields),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _buildInputDecoration(
              context: context,
              labelText: 'Password',
              hintText: 'Create a strong password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Please enter a password';
              if (value!.length < 8) return 'Password must be at least 8 characters';
              if (!value.contains(RegExp(r'[A-Z]'))) return 'Password must contain an uppercase letter';
              if (!value.contains(RegExp(r'[0-9]'))) return 'Password must contain a number';
              return null;
            },
          ),
          SizedBox(height: context.spaceBtwFields),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: _buildInputDecoration(
              context: context,
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Please confirm your password';
              if (value != _passwordController.text) return 'Passwords do not match';
              return null;
            },
          ),
          SizedBox(height: context.lg),
          const PasswordRequirements(),
          SizedBox(height: context.lg),
          TermsAndConditions(
            agreeToTerms: _agreeToTerms,
            onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
          ),
          SizedBox(height: context.lg),
          SizedBox(
            width: double.infinity,
            height: context.createButtonHeight,
            child: ElevatedButton(
              onPressed: (!_agreeToTerms || _isLoading) ? null : _handleSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue600,
                disabledBackgroundColor: AppColors.grey300,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.white))
                  : Text('Create Account', style: context.buttonWhiteTextStyle),
            ),
          ),
          SizedBox(height: context.spaceBtwFields),
          const SignInRedirect(),
          SizedBox(height: context.lg),
        ],
      ),
    );
  }
}