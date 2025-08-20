// models/profile_summary_data.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../widgets/info_row.dart';


class ProfileSummaryData {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? location;
  final List<String> skills;
  final String? language;
  final String? experienceLevel;
  final String? preferredInterviewTime;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool interviewReminders;
  final bool weeklyReports;

  const ProfileSummaryData({
    this.firstName,
    this.lastName,
    this.username,
    this.gender,
    this.dateOfBirth,
    this.location,
    this.skills = const [],
    this.language,
    this.experienceLevel,
    this.preferredInterviewTime,
    this.emailNotifications = false,
    this.pushNotifications = false,
    this.interviewReminders = false,
    this.weeklyReports = false,
  });

  factory ProfileSummaryData.fromMap(Map<String, dynamic> data) {
    return ProfileSummaryData(
      firstName: data['firstName'],
      lastName: data['lastName'],
      username: data['username'],
      gender: data['gender'],
      dateOfBirth: data['dateOfBirth'],
      location: data['location'],
      skills: List<String>.from(data['skills'] ?? []),
      language: data['language'],
      experienceLevel: data['experienceLevel'],
      preferredInterviewTime: data['preferredInterviewTime'],
      emailNotifications: data['emailNotifications'] ?? false,
      pushNotifications: data['pushNotifications'] ?? false,
      interviewReminders: data['interviewReminders'] ?? false,
      weeklyReports: data['weeklyReports'] ?? false,
    );
  }

  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  String get formattedDateOfBirth {
    if (dateOfBirth == null) return 'Not specified';
    return '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}';
  }

  bool get hasSkills => skills.isNotEmpty;

  List<Widget> buildPersonalInfoRows(BuildContext context) {
    return [
      InfoRow(label: 'Name', value: fullName.isEmpty ? 'Not specified' : fullName),
      InfoRow(label: 'Username', value: username ?? 'Not specified'),
      InfoRow(label: 'Gender', value: gender ?? 'Not specified'),
      InfoRow(label: 'Date of Birth', value: formattedDateOfBirth),
      InfoRow(label: 'Location', value: location ?? 'Not specified'),
    ];
  }

  List<Widget> buildSkillsSection(BuildContext context) {
    return [
      Text(
        'Selected Skills (${skills.length})',
        style: context.hintTextGreyStyle,
      ),
      SizedBox(height: context.paddingSM),
      // SkillsChips(skills: skills),
    ];
  }

  List<Widget> buildPreferencesRows(BuildContext context) {
    return [
      InfoRow(label: 'Language', value: language ?? 'English'),
      InfoRow(label: 'Experience Level', value: experienceLevel ?? 'Not specified'),
      InfoRow(label: 'Preferred Interview Time', value: preferredInterviewTime ?? 'Not specified'),
      SizedBox(height: context.paddingSM),
      Text(
        'Notification Settings',
        style: context.detailHeaderStyle,
      ),
      SizedBox(height: context.paddingXS),
      _buildNotificationSetting('Email', emailNotifications, context),
      _buildNotificationSetting('Push', pushNotifications, context),
      _buildNotificationSetting('Reminders', interviewReminders, context),
      _buildNotificationSetting('Weekly Reports', weeklyReports, context),
    ];
  }

  Widget _buildNotificationSetting(String label, bool enabled, BuildContext context) {
    return Text(
      '$label: ${enabled ? 'Enabled' : 'Disabled'}',
      style: context.hintTextGreyStyle,
    );
  }
}