import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/profile_setup_progress.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_one/step_one_profile_picture.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/step_two_basic_details.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_three/step_three_skills.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_four/step_four_preferences.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_five/step_five_summary.dart';
import 'package:interview/features/resume/widgets/final_step_dialog.dart';
import '../../../../core/constants/colors.dart';
import '../../services/resume_upload_service.dart';

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

  final Map<String, dynamic> _profileData = {};
  late final ResumeUploadService _resumeUploadService;

  @override
  void initState() {
    super.initState();
    _resumeUploadService = ResumeUploadService(
      context: context,
      onProfileDataUpdate: _updateProfileData,
      onShowError: _showErrorMessage,
    );

    if (widget.signupData != null) {
      _profileData.addAll(widget.signupData!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showResumeUploadDialog();
    });
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

  Future<void> _showResumeUploadDialog() async {
    if (!mounted) return;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return FinalStepDialog(
          title: 'Quick Setup',
          subTitle: 'Would you like to upload your resume to automatically fill in your profile details?',
          yes: 'Upload Resume',
          no: 'Skip for now',
          onYesPressed: () async {
            await _resumeUploadService.uploadResume();
          },
        );
      },
    );
  }

  void _showErrorMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.white),
            SizedBox(width: context.spaceBtwItems),
            Expanded(child: Text(message, style: context.snackBarTextStyle)),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusMD)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _finishSetup() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      _showSuccessMessage('Profile setup completed successfully!');
      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      _showErrorMessage('Profile setup failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.white),
            SizedBox(width: context.spaceBtwItems),
            Expanded(child: Text(message, style: context.snackBarTextStyle)),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusMD)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: context.defaultPadding,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.lg),
                  child: ProfileSetupProgress(
                    currentStep: _currentStep + 1,
                    totalSteps: _totalSteps,
                  ),
                ),
                SizedBox(height: context.spaceBtwFields),
                if (_currentStep == 0)
                  TextButton.icon(
                    onPressed: _showResumeUploadDialog,
                    icon: Icon(Icons.upload_file, size: context.iconSizeSM, color: AppColors.blackLight),
                    label: Text('Upload Resume', style: context.buttonTextStyle.copyWith(color: AppColors.blackLight)),
                  ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentStep = index);
                    },
                    children: [
                      StepOneProfilePicture(initialData: _profileData, onDataChanged: _updateProfileData),
                      StepTwoBasicDetails(initialData: _profileData, onDataChanged: _updateProfileData),
                      StepThreeSkills(initialData: _profileData, onDataChanged: _updateProfileData),
                      StepFourPreferences(initialData: _profileData, onDataChanged: _updateProfileData),
                      StepFiveSummary(profileData: _profileData, onDataChanged: _updateProfileData),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(context.lg),
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: SizedBox(
                            height: context.createButtonHeight,
                            child: OutlinedButton(
                              onPressed: _previousStep,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.blackLight),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
                              ),
                              child: Text('Back', style: context.buttonTextStyle.copyWith(color: AppColors.blackLight)),
                            ),
                          ),
                        ),
                      if (_currentStep > 0) SizedBox(width: context.spaceBtwItems),
                      Expanded(
                        child: SizedBox(
                          height: context.createButtonHeight,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : (_currentStep == _totalSteps - 1 ? _finishSetup : _nextStep),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blackLight,
                              disabledBackgroundColor: AppColors.grey400,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
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