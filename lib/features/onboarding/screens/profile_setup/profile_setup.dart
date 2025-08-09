import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/profile_setup_form.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/profile_setup_header.dart';
import '../../../../core/constants/colors.dart';


class ProfileSetupScreen extends StatelessWidget {
  final Map<String, dynamic>? signupData;

  const ProfileSetupScreen({super.key, this.signupData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Profile Setup',
          style: context.headerStyle.copyWith(color: AppColors.black87),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.spaceBtwFields),
              const ProfileSetupHeader(),
              SizedBox(height: context.spaceBtwSections),
              ProfileSetupForm(signupData: signupData),
            ],
          ),
        ),
      ),
    );
  }
}