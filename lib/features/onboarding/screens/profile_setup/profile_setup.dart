import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/profile_setup_progress.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/setup_footer.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_one/step_one_profile_picture.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/step_two_basic_details.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_three/step_three_skills.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_four/step_four_preferences.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_five/step_five_summary.dart';
import '../../../../core/constants/colors.dart';
import 'controllers/profile_setup_controllers.dart';

class ProfileSetupScreen extends StatefulWidget {
  final Map<String, dynamic>? signupData;

  const ProfileSetupScreen({super.key, this.signupData});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  late ProfileSetupController _controller;

  // Add a GlobalKey for the current step widget
  final List<GlobalKey> _stepKeys = List.generate(5, (index) => GlobalKey());

  // Track if Step 1 is completed for Skip button logic
  bool _isStepOneCompleted = false;


  @override
  void initState() {
    super.initState();
    _controller = ProfileSetupController(
      context: context,
      pageController: _pageController,
      onStateChanged: () => setState(() {}),
      signupData: widget.signupData,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.showResumeUploadDialog();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Method to handle skip functionality
  void _handleSkip() {
    _controller.skipToFinalStep();
    if (_isStepOneCompleted) {
      // Navigate directly to the final step (step 4, index 4)
      _controller.skipToFinalStep();
    }
  }

  // Method to validate Step 1 and update completion status
  bool _validateStepOne() {
    final currentStepKey = _stepKeys[0];
    final stepOneState = currentStepKey.currentState;

    try {
      if (stepOneState != null) {
        bool isValid = (stepOneState as dynamic).validateStep() as bool? ?? false;
        setState(() {
          _isStepOneCompleted = isValid;
        });
        return isValid;
      }
    } catch (e) {
      setState(() {
        _isStepOneCompleted = false;
      });
      return false;
    }

    setState(() {
      _isStepOneCompleted = false;
    });
    return false;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildResumeUploadButton(),
                    _buildSkipButton(),
                  ],
                ),
                _buildProgressIndicator(),
                SizedBox(height: context.spaceBtwFields),
                _buildPageView(),
                _buildBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.lg),
      child: ProfileSetupProgress(
        currentStep: _controller.currentStep + 1,
        totalSteps: _controller.totalSteps,
      ),
    );
  }

  Widget _buildResumeUploadButton() {
    if (_controller.currentStep != 0) return const SizedBox.shrink();

    return TextButton.icon(
      onPressed: _controller.showResumeUploadDialog,
      icon: const Icon(Icons.cloud_upload_rounded),
      label: Text(
        AppStrings.uploadResume,
        style: context.buttonSmallStyle.copyWith(color: AppColors.purple),
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: _isStepOneCompleted ? _handleSkip : null,
      child: Text(
        textAlign: TextAlign.right,
        AppStrings.skip.toUpperCase(),
        style: context.subheadingStyle(
          color: _isStepOneCompleted ? AppColors.purple : AppColors.grey400,
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _controller.onPageChanged,
        children: [
          StepOneProfilePicture(
            key: _stepKeys[0],
            initialData: _controller.profileData,
            onDataChanged: _controller.updateProfileData,
            onValidationChanged: (isValid) {
              _controller.updateStepValidation(0, isValid);
              setState(() {
                _isStepOneCompleted = isValid;
              });
            },
          ),
          StepTwoBasicDetails(
            key: _stepKeys[1],
            initialData: _controller.profileData,
            onDataChanged: _controller.updateProfileData,
          ),
          StepThreeSkills(
            key: _stepKeys[2],
            initialData: _controller.profileData,
            onDataChanged: _controller.updateProfileData,
          ),
          StepFourPreferences(
            key: _stepKeys[3],
            initialData: _controller.profileData,
            onDataChanged: _controller.updateProfileData,
          ),
          StepFiveSummary(
            key: _stepKeys[4],
            profileData: _controller.profileData,
            onDataChanged: _controller.updateProfileData,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return ProfileSetupBottomButtons(
      currentStep: _controller.currentStep,
      totalSteps: _controller.totalSteps,
      isLoading: _controller.isLoading,
      onPrevious: _controller.previousStep,
      onNext: _controller.nextStep,
      onFinish: _controller.finishSetup,
      validateCurrentStep: () {
        // Only validate Step 1 strictly
        if (_controller.currentStep == 0) {
          return _validateStepOne();
        }

        // For other steps, allow proceeding (no strict validation)
        return true;
      },
    );
  }
}