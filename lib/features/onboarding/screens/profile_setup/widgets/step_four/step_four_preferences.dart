import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_four/widgets/preferences_drop_down.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_four/widgets/preferences_section.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_four/widgets/preferences_switch_tile.dart';

import '../../../../../../core/constants/colors.dart';
import 'controllers/preferences_controllers.dart';
import 'models/preferences_model.dart';


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
  late PreferenceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PreferenceController();
    _controller.initializeFromMap(widget.initialData);
    _controller.addListener(_onPreferenceChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPreferenceChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onPreferenceChanged() {
    widget.onDataChanged(_controller.preferenceData.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        final preferences = _controller.preferenceData;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.spaceBtwFields),

              // Header
              Text(
                AppStrings.preferencesTitle,
                style: context.headingStyle(color: AppColors.black87),
              ),
              SizedBox(height: context.sm),
              Text(
                AppStrings.preferencesSubtitle,
                style: context.subheadingStyle(color: AppColors.textGrey),
              ),

              SizedBox(height: context.spaceBtwSections),

              // Language preference
              PreferenceSection(
                title: AppStrings.languageSectionTitle,
                subtitle: AppStrings.languageSectionSubtitle,
                icon: Icons.language,
                child: PreferenceDropdown(
                  value: preferences.language,
                  items: PreferenceConstants.languages,
                  hint: AutofillHints.language,
                  onChanged: (value) {
                    if (value != null) {
                      _controller.updateLanguage(value);
                    }
                  },
                ),
              ),

              // Experience level
              PreferenceSection(
                title: AppStrings.experienceSectionTitle,
                subtitle: AppStrings.experienceSectionSubtitle,
                icon: Icons.trending_up,
                child: PreferenceDropdown(
                  value: preferences.experienceLevel,
                  items: PreferenceConstants.experienceLevels,
                  hint: AppStrings.experience,
                  onChanged: (value) {
                    if (value != null) {
                      _controller.updateExperienceLevel(value);
                    }
                  },
                ),
              ),

              // Interview time preference
              PreferenceSection(
                title: AppStrings.interviewTimeSectionTitle,
                subtitle: AppStrings.interviewTimeSectionSubtitle,
                icon: Icons.schedule,
                child: PreferenceDropdown(
                  value: preferences.preferredInterviewTime,
                  items: PreferenceConstants.interviewTimes,
                  hint: AppStrings.interviewTimeSectionTitle,
                  onChanged: (value) {
                    if (value != null) {
                      _controller.updatePreferredInterviewTime(value);
                    }
                  },
                ),
              ),

              // Notification preferences
              PreferenceSection(
                title: AppStrings.notificationsSectionTitle,
                subtitle: AppStrings.notificationsSectionSubtitle,
                icon: Icons.notifications_outlined,
                child: Column(
                  children: [
                    PreferenceSwitchTile(
                      title: AppStrings.emailNotificationsSwitch,
                      subtitle:AppStrings.emailNotificationsSwitchSubtitle,
                      value: preferences.emailNotifications,
                      onChanged: _controller.updateEmailNotifications,
                    ),
                    PreferenceSwitchTile(
                      title: AppStrings.pushNotificationsSwitch,
                      subtitle: AppStrings.pushNotificationsSwitchSubtitle,
                      value: preferences.pushNotifications,
                      onChanged: _controller.updatePushNotifications,
                    ),
                    PreferenceSwitchTile(
                      title: AppStrings.interviewRemindersSwitch,
                      subtitle: AppStrings.interviewRemindersSwitchSubtitle,
                      value: preferences.interviewReminders,
                      onChanged: _controller.updateInterviewReminders,
                    ),
                    PreferenceSwitchTile(
                      title: AppStrings.weeklyReportsSwitch,
                      subtitle: AppStrings.weeklyReportsSwitchSubtitle,
                      value: preferences.weeklyReports,
                      onChanged: _controller.updateWeeklyReports,
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spaceBtwSections),
            ],
          ),
        );
      },
    );
  }
}