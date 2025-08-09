import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../core/constants/colors.dart';

class ProfileSetupForm extends StatefulWidget {
  final Map<String, dynamic>? signupData;

  const ProfileSetupForm({super.key, this.signupData});

  @override
  State<ProfileSetupForm> createState() => _ProfileSetupFormState();
}

class _ProfileSetupFormState extends State<ProfileSetupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleProfileSetup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      // Simulate saving profile data with signup data
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile setup failed: ${e.toString()}'),
            backgroundColor: AppColors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusMD)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  InputDecoration _buildInputDecoration(BuildContext context, {required String label, required String hint, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
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
            controller: _firstNameController,
            decoration: _buildInputDecoration(context, label: 'First Name', hint: 'Enter your first name', icon: Icons.person_outline),
            validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your first name' : null,
          ),
          SizedBox(height: context.spaceBtwFields),
          TextFormField(
            controller: _lastNameController,
            decoration: _buildInputDecoration(context, label: 'Last Name', hint: 'Enter your last name', icon: Icons.person_outline),
            validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your last name' : null,
          ),
          SizedBox(height: context.spaceBtwFields),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: _buildInputDecoration(context, label: 'Phone Number', hint: 'Enter your phone number', icon: Icons.phone_outlined),
            validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your phone number' : null,
          ),
          SizedBox(height: context.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            height: context.createButtonHeight,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleProfileSetup,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue600,
                disabledBackgroundColor: AppColors.grey400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radiusLG),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.white))
                  : Text('Complete Setup', style: context.buttonWhiteTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}