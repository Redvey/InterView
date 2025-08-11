// profile_setup_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/profile_setup_progress.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_one/step_one_profile_picture.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two_basic_details.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_three_skills.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_four_preferences.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_five_summary.dart';
import '../../../../core/constants/colors.dart';

class ProfileSetupScreen extends StatefulWidget {
  final Map<String, dynamic>? signupData;

  const ProfileSetupScreen({super.key, this.signupData});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 5;
  bool _isLoading = false;

  // Store user data across steps
  final Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    // Initialize with signup data if available
    if (widget.signupData != null) {
      _profileData.addAll(widget.signupData!);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateProfileData(Map<String, dynamic> stepData) {
    setState(() {
      _profileData.addAll(stepData);
    });
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishSetup() async {
    setState(() => _isLoading = true);

    try {
      // Simulate API call to save profile data
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile setup completed successfully!',
              style: context.snackBarTextStyle,
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
          ),
        );

        // Navigate to home
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile setup failed: ${e.toString()}',
              style: context.snackBarTextStyle,
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Padding(
            padding: context.defaultPadding,
            child: Column(
              children: [

                // Progress indicator
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.lg),
                  child: ProfileSetupProgress(
                    currentStep: _currentStep + 1,
                    totalSteps: _totalSteps,
                  ),
                ),
                SizedBox(height: context.spaceBtwFields),

                // Page content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentStep = index);
                    },
                    children: [
                      StepOneProfilePicture(
                        initialData: _profileData,
                        onDataChanged: _updateProfileData,
                      ),
                      StepTwoBasicDetails(
                        initialData: _profileData,
                        onDataChanged: _updateProfileData,
                      ),
                      StepThreeSkills(
                        initialData: _profileData,
                        onDataChanged: _updateProfileData,
                      ),
                      StepFourPreferences(
                        initialData: _profileData,
                        onDataChanged: _updateProfileData,
                      ),
                      StepFiveSummary(
                        profileData: _profileData,
                        onDataChanged: _updateProfileData,
                      ),
                    ],
                  ),
                ),

                // Navigation buttons
                Container(
                  padding: EdgeInsets.all(context.lg),
                  child: Row(
                    children: [
                      // Back button
                      if (_currentStep > 0)
                        Expanded(
                          child: SizedBox(
                            height: context.createButtonHeight,
                            child: OutlinedButton(
                              onPressed: _previousStep,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.blackLight),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(context.radiusLG),
                                ),
                              ),
                              child: Text(
                                'Back',
                                style: context.buttonTextStyle.copyWith(
                                  color: AppColors.blackLight,
                                ),
                              ),
                            ),
                          ),
                        ),

                      if (_currentStep > 0) SizedBox(width: context.spaceBtwItems),

                      // Next/Finish button
                      Expanded(
                        flex: _currentStep == 0 ? 1 : 1,
                        child: SizedBox(
                          height: context.createButtonHeight,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : (_currentStep == _totalSteps - 1 ? _finishSetup : _nextStep),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blackLight,
                              disabledBackgroundColor: AppColors.grey400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(context.radiusLG),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                              height: context.iconSizeSX,
                              width: context.iconSizeSX,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(AppColors.white),
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              _currentStep == _totalSteps - 1 ? 'Finish Setup' : 'Next',
                              style: context.buttonWhiteTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}