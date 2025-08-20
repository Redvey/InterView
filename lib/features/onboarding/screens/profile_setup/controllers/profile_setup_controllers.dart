import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/widgets/final_step_dialog.dart';
import '../../../../../core/constants/strings.dart';
import '../../../services/resume_upload_service.dart';

class ProfileSetupController {
  final BuildContext context;
  final PageController pageController;
  final VoidCallback onStateChanged;

  int _currentStep = 0;
  final int _totalSteps = 5;
  bool _isLoading = false;
  final Map<String, dynamic> _profileData = {};
  late final ResumeUploadService _resumeUploadService;
  final List<bool> _stepValidationStates = List.filled(5, false);

  ProfileSetupController({
    required this.context,
    required this.pageController,
    required this.onStateChanged,
    Map<String, dynamic>? signupData,
  }) {
    _resumeUploadService = ResumeUploadService(
      context: context,
      onProfileDataUpdate: updateProfileData,
      onShowError: showErrorMessage,
    );

    if (signupData != null) {
      _profileData.addAll(signupData);
    }
  }

  // Getters
  int get currentStep => _currentStep;
  int get totalSteps => _totalSteps;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get profileData => _profileData;

  bool get isCurrentStepValid {
    return _stepValidationStates[_currentStep];
  }

  bool get canProceedToNext {
    return isCurrentStepValid && !_isLoading;
  }

  // Public Methods
  void updateProfileData(Map<String, dynamic> stepData) {
    _profileData.addAll(stepData);
    onStateChanged();
  }

  void updateStepValidation(int step, bool isValid) {
    if (step >= 0 && step < _stepValidationStates.length) {
      _stepValidationStates[step] = isValid;
      onStateChanged();
    }
  }

  void nextStep() {
    if (!canProceedToNext) return;

    if (_currentStep < _totalSteps - 1) {
      _currentStep++;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      onStateChanged();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      onStateChanged();
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    _currentStep = index;
    onStateChanged();
  }

  void skipToFinalStep() {
    // Navigate directly to the final step (index 4)
    _currentStep = _totalSteps - 1; // This should be 4 for the 5th step (0-indexed)
    pageController.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    onStateChanged();
  }

  Future<void> showResumeUploadDialog() async {
    if (!context.mounted) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return FinalStepDialog(
          title: AppStrings.quickSetup,
          subTitle: AppStrings.resumeUploadDescription,
          yes: AppStrings.uploadResume,
          no: AppStrings.skipForNow,
          onYesPressed: () async {
            // Ensure the dialog is popped before awaiting the upload,
            // to avoid issues with the context
            Navigator.of(context).pop();
            await _resumeUploadService.uploadResume();
          },
        );
      },
    );
  }

  void showErrorMessage(String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.white),
            SizedBox(width: context.spaceBtwItems),
            Expanded(
              child: Text(message, style: context.snackBarTextStyle),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void showSuccessMessage(String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.white),
            SizedBox(width: context.spaceBtwItems),
            Expanded(
              child: Text(message, style: context.snackBarTextStyle),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> finishSetup() async {
    if (!context.mounted) return;

    // Show confirmation dialog first
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return FinalStepDialog(
          title:  "Complete Profile Setup?",
          subTitle:  "You can always edit your profile later.",
          yes: AppStrings.finishSetup,
          no: AppStrings.cancel,
          onYesPressed: () {
            Navigator.of(context).pop();
            _executeFinishSetup();
          },
          onNoPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _executeFinishSetup() async {
    _isLoading = true;
    onStateChanged();

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!context.mounted) return;
      showSuccessMessage(AppStrings.profileSetupCompleted);

      if (!context.mounted) return;
      context.go('/home');
    } catch (e) {
      if (!context.mounted) return;
      showErrorMessage('${AppStrings.profileSetupFailed}${e.toString()}');
    } finally {
      if (context.mounted) {
        _isLoading = false;
        onStateChanged();
      }
    }
  }


  void dispose() {
    // Clean up any resources if needed
  }
}