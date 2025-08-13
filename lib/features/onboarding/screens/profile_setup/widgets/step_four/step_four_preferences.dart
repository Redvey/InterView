// step_four_preferences.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../core/constants/colors.dart';

class StepFourPreferences extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onDataChanged;

  const StepFourPreferences({
    super.key,
    required this.initialData,
    required this.onDataChanged,
  });

  @override
  State<StepFourPreferences> createState() => _StepFourPreferencesState();
}

class _StepFourPreferencesState extends State<StepFourPreferences> {
  String _selectedLanguage = 'English';
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _interviewReminders = true;
  bool _weeklyReports = false;
  String _preferredInterviewTime = 'Morning (9 AM - 12 PM)';
  String _experienceLevel = 'Intermediate (2-5 years)';

  final List<String> _languages = [
    'English', 'Spanish', 'French', 'German', 'Chinese', 'Japanese', 'Hindi', 'Arabic'
  ];

  final List<String> _interviewTimes = [
    'Morning (9 AM - 12 PM)',
    'Afternoon (12 PM - 5 PM)',
    'Evening (5 PM - 9 PM)',
    'Flexible'
  ];

  final List<String> _experienceLevels = [
    'Beginner (0-2 years)',
    'Intermediate (2-5 years)',
    'Senior (5-10 years)',
    'Expert (10+ years)'
  ];

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialData['language'] ?? 'English';
    _emailNotifications = widget.initialData['emailNotifications'] ?? true;
    _pushNotifications = widget.initialData['pushNotifications'] ?? true;
    _interviewReminders = widget.initialData['interviewReminders'] ?? true;
    _weeklyReports = widget.initialData['weeklyReports'] ?? false;
    _preferredInterviewTime = widget.initialData['preferredInterviewTime'] ?? 'Morning (9 AM - 12 PM)';
    _experienceLevel = widget.initialData['experienceLevel'] ?? 'Intermediate (2-5 years)';
  }

  void _updateData() {
    widget.onDataChanged({
      'language': _selectedLanguage,
      'emailNotifications': _emailNotifications,
      'pushNotifications': _pushNotifications,
      'interviewReminders': _interviewReminders,
      'weeklyReports': _weeklyReports,
      'preferredInterviewTime': _preferredInterviewTime,
      'experienceLevel': _experienceLevel,
    });
  }

  Widget _buildPreferenceSection({
    required String title,
    required String subtitle,
    required Widget child,
    IconData? icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spaceBtwFields),
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: AppColors.grey300,
          width: context.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: AppColors.blackLight,
                  size: context.iconSizeMD,
                ),
                SizedBox(width: context.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.infoSmallHeaderStyle,
                    ),
                    SizedBox(height: context.xs),
                    Text(
                      subtitle,
                      style: context.hintTextGreyStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.paddingMD),
          child,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.paddingSM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.detailHeaderStyle,
                ),
                SizedBox(height: context.xs),
                Text(
                  subtitle,
                  style: context.hintTextGreyStyle,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.blackLight,
            activeTrackColor: AppColors.blackLight.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.grey500,
            inactiveTrackColor: AppColors.grey300,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
          borderSide: BorderSide(color: AppColors.grey400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.radiusMD),
          borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.paddingMD,
          vertical: context.paddingSM,
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      hint: Text(hint),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: AppColors.white,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

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
            'Customize Your Experience',
            style: context.headingStyle(color: AppColors.black87),
          ),
          SizedBox(height: context.sm),
          Text(
            'Set your preferences to tailor the app to your needs',
            style: context.subheadingStyle(color: AppColors.textGrey),
          ),

          SizedBox(height: context.spaceBtwSections),

          // Language preference
          _buildPreferenceSection(
            title: 'Language',
            subtitle: 'Choose your preferred language',
            icon: Icons.language,
            child: _buildDropdownField(
              value: _selectedLanguage,
              items: _languages,
              hint: 'Select language',
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                  _updateData();
                }
              },
            ),
          ),

          // Experience level
          _buildPreferenceSection(
            title: 'Experience Level',
            subtitle: 'Help us understand your experience',
            icon: Icons.trending_up,
            child: _buildDropdownField(
              value: _experienceLevel,
              items: _experienceLevels,
              hint: 'Select experience level',
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _experienceLevel = newValue;
                  });
                  _updateData();
                }
              },
            ),
          ),

          // Interview time preference
          _buildPreferenceSection(
            title: 'Preferred Interview Time',
            subtitle: 'When do you prefer to take interviews?',
            icon: Icons.schedule,
            child: _buildDropdownField(
              value: _preferredInterviewTime,
              items: _interviewTimes,
              hint: 'Select preferred time',
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _preferredInterviewTime = newValue;
                  });
                  _updateData();
                }
              },
            ),
          ),

          // Notification preferences
          _buildPreferenceSection(
            title: 'Notifications',
            subtitle: 'Manage how you receive updates',
            icon: Icons.notifications_outlined,
            child: Column(
              children: [
                _buildSwitchTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive updates via email',
                  value: _emailNotifications,
                  onChanged: (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                    _updateData();
                  },
                ),
                _buildSwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Get real-time app notifications',
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                    _updateData();
                  },
                ),
                _buildSwitchTile(
                  title: 'Interview Reminders',
                  subtitle: 'Get reminded before scheduled interviews',
                  value: _interviewReminders,
                  onChanged: (value) {
                    setState(() {
                      _interviewReminders = value;
                    });
                    _updateData();
                  },
                ),
                _buildSwitchTile(
                  title: 'Weekly Reports',
                  subtitle: 'Receive weekly progress summaries',
                  value: _weeklyReports,
                  onChanged: (value) {
                    setState(() {
                      _weeklyReports = value;
                    });
                    _updateData();
                  },
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