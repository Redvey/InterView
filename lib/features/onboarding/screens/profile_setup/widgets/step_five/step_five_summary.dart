// step_five_summary.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../core/constants/colors.dart';

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
    // Initialize with existing data if available
    _agreedToTerms = widget.profileData['agreedToTerms'] ?? false;
    _agreedToPrivacy = widget.profileData['agreedToPrivacy'] ?? false;
  }

  void _updateData() {
    widget.onDataChanged({
      'agreedToTerms': _agreedToTerms,
      'agreedToPrivacy': _agreedToPrivacy,
    });
  }

  Widget _buildSummaryCard({
    required String title,
    required List<Widget> children,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spaceBtwFields),
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: color,
          width: context.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.paddingSM),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: context.iconSizeMD,
                ),
              ),
              SizedBox(width: context.sm),
              Text(
                title,
                style: context.infoSmallHeaderStyle,
              ),
            ],
          ),
          SizedBox(height: context.paddingMD),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.paddingSM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.screenWidth * 0.3,
            child: Text(
              label,
              style: context.hintTextGreyStyle,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.detailHeaderStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsChips(List<String> skills) {
    return Wrap(
      children: skills.map((skill) => Container(
        margin: EdgeInsets.only(
          right: context.xs,
          bottom: context.xs,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingSM,
          vertical: context.paddingXS,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundGreen,
          borderRadius: BorderRadius.circular(context.radiusSM),
        ),
        child: Text(
          skill,
          style: context.buttonSmallStyle.copyWith(
            color: AppColors.white,
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: context.paddingMD),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.blackLight,
            checkColor: AppColors.white,
          ),
          SizedBox(width: context.sm),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.detailHeaderStyle,
                  ),
                  Text(
                    subtitle,
                    style: context.hintTextGreyStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not specified';
    return '${date.day}/${date.month}/${date.year}';
  }

  bool get _canProceed => _agreedToTerms && _agreedToPrivacy;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.spaceBtwFields),

          // Header
          Text(
            'Review Your Profile',
            style: context.headingStyle(color: AppColors.black87),
          ),
          SizedBox(height: context.sm),
          Text(
            'Please review your information before completing setup',
            style: context.subheadingStyle(color: AppColors.textGrey),
          ),

          SizedBox(height: context.spaceBtwSections),

          // Personal Information
          _buildSummaryCard(
            title: 'Personal Information',
            icon: Icons.person_outline,
            color: AppColors.blue600,
            children: [
              _buildInfoRow('Name', '${widget.profileData['firstName'] ?? ''} ${widget.profileData['lastName'] ?? ''}'),
              _buildInfoRow('Username', widget.profileData['username'] ?? 'Not specified'),
              _buildInfoRow('Gender', widget.profileData['gender'] ?? 'Not specified'),
              _buildInfoRow('Date of Birth', _formatDate(widget.profileData['dateOfBirth'])),
              _buildInfoRow('Location', widget.profileData['location'] ?? 'Not specified'),
            ],
          ),

          // Skills
          if (widget.profileData['skills'] != null && (widget.profileData['skills'] as List).isNotEmpty)
            _buildSummaryCard(
              title: 'Skills & Expertise',
              icon: Icons.star_outline,
              color: AppColors.backgroundGreen,
              children: [
                Text(
                  'Selected Skills (${(widget.profileData['skills'] as List).length})',
                  style: context.hintTextGreyStyle,
                ),
                SizedBox(height: context.paddingSM),
                _buildSkillsChips(List<String>.from(widget.profileData['skills'] ?? [])),
              ],
            ),

          // Preferences
          _buildSummaryCard(
            title: 'Preferences',
            icon: Icons.settings_outlined,
            color: AppColors.backgroundOrange,
            children: [
              _buildInfoRow('Language', widget.profileData['language'] ?? 'English'),
              _buildInfoRow('Experience Level', widget.profileData['experienceLevel'] ?? 'Not specified'),
              _buildInfoRow('Preferred Interview Time', widget.profileData['preferredInterviewTime'] ?? 'Not specified'),
              SizedBox(height: context.paddingSM),
              Text(
                'Notification Settings',
                style: context.detailHeaderStyle,
              ),
              SizedBox(height: context.paddingXS),
              Text(
                'Email: ${widget.profileData['emailNotifications'] == true ? 'Enabled' : 'Disabled'}',
                style: context.hintTextGreyStyle,
              ),
              Text(
                'Push: ${widget.profileData['pushNotifications'] == true ? 'Enabled' : 'Disabled'}',
                style: context.hintTextGreyStyle,
              ),
              Text(
                'Reminders: ${widget.profileData['interviewReminders'] == true ? 'Enabled' : 'Disabled'}',
                style: context.hintTextGreyStyle,
              ),
              Text(
                'Weekly Reports: ${widget.profileData['weeklyReports'] == true ? 'Enabled' : 'Disabled'}',
                style: context.hintTextGreyStyle,
              ),
            ],
          ),

          // Terms and conditions
          Container(
            padding: EdgeInsets.all(context.paddingMD),
            decoration: BoxDecoration(
              color: AppColors.backgroundYellow,
              borderRadius: BorderRadius.circular(context.radiusMD),
              border: Border.all(
                color: AppColors.buttonYellow,
                width: context.borderWidthThin,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms & Conditions',
                  style: context.infoSmallHeaderStyle,
                ),
                SizedBox(height: context.paddingMD),
                _buildCheckboxTile(
                  title: 'I agree to the Terms of Service',
                  subtitle: 'You must agree to our terms to continue',
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                    _updateData();
                  },
                ),
                _buildCheckboxTile(
                  title: 'I agree to the Privacy Policy',
                  subtitle: 'We respect your privacy and data security',
                  value: _agreedToPrivacy,
                  onChanged: (value) {
                    setState(() {
                      _agreedToPrivacy = value ?? false;
                    });
                    _updateData();
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: context.spaceBtwFields),

          // Validation message
          if (!_canProceed)
            Container(
              padding: EdgeInsets.all(context.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: BorderRadius.circular(context.radiusMD),
                border: Border.all(
                  color: AppColors.error,
                  width: context.borderWidthThin,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_outlined,
                    color: AppColors.error,
                    size: context.iconSizeMD,
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Text(
                      'Please agree to both Terms of Service and Privacy Policy to continue',
                      style: context.hintTextColorful(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: context.spaceBtwSections),
        ],
      ),
    );
  }
}