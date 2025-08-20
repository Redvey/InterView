// step_five_summary.dart (Updated with constants)
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_five/widgets/step_five_constants.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_five/widgets/terms_and_condition.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_five/widgets/validation_step_five.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/strings.dart';
import 'widgets/summary_card.dart';
import 'models/profile_summary_data.dart';

class StepFiveSummary extends StatefulWidget {
  final Map<String, dynamic> profileData;
  final Function(Map<String, dynamic>) onDataChanged;

  const StepFiveSummary({
    super.key,
    required this.profileData,
    required this.onDataChanged,
  });

  @override
  State<StepFiveSummary> createState() => _StepFiveSummaryState();
}

class _StepFiveSummaryState extends State<StepFiveSummary> {
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;

  @override
  void initState() {
    super.initState();
    _initializeAgreements();
  }

  void _initializeAgreements() {
    _agreedToTerms = widget.profileData['agreedToTerms'] ?? false;
    _agreedToPrivacy = widget.profileData['agreedToPrivacy'] ?? false;
  }

  void _updateData() {
    widget.onDataChanged({
      'agreedToTerms': _agreedToTerms,
      'agreedToPrivacy': _agreedToPrivacy,
    });
  }

  void _onTermsChanged(bool value) {
    setState(() {
      _agreedToTerms = value;
    });
    _updateData();
  }

  void _onPrivacyChanged(bool value) {
    setState(() {
      _agreedToPrivacy = value;
    });
    _updateData();
  }

  bool get _canProceed => _agreedToTerms && _agreedToPrivacy;

  @override
  Widget build(BuildContext context) {
    final profileSummary = ProfileSummaryData.fromMap(widget.profileData);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.spaceBtwFields),

          _buildHeader(context),
          SizedBox(height: context.spaceBtwSections),

          // Personal Information
          SummaryCard(
            title: AppStrings.personalInfoTitle,
            icon: StepFiveConstants.personalInfoIcon,
            color: AppColors.personalInfoColor,
            children: profileSummary.buildPersonalInfoRows(context),
          ),

          // Skills
          if (profileSummary.hasSkills)
            SummaryCard(
              title: AppStrings.skillsTitle,
              icon: StepFiveConstants.skillsIcon,
              color: AppColors.skillsColor,
              children: profileSummary.buildSkillsSection(context),
            ),

          // Preferences
          SummaryCard(
            title: AppStrings.preferencesTitle,
            icon: StepFiveConstants.preferencesIcon,
            color: AppColors.preferencesColor,
            children: profileSummary.buildPreferencesRows(context),
          ),

          // Terms and Conditions
          TermsConditionsSection(
            agreedToTerms: _agreedToTerms,
            agreedToPrivacy: _agreedToPrivacy,
            onTermsChanged: _onTermsChanged,
            onPrivacyChanged: _onPrivacyChanged,
          ),

          SizedBox(height: context.spaceBtwFields),

          // Validation message
          if (!_canProceed)
            const ValidationMessage(
              message: AppStrings.validationMessage,
            ),

          SizedBox(height: context.spaceBtwSections),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.pageTitle,
          style: context.headingStyle(color: AppColors.black87),
        ),
        SizedBox(height: context.sm),
        Text(
          AppStrings.pageSubtitle,
          style: context.subheadingStyle(color: AppColors.textGrey),
        ),
      ],
    );
  }
}