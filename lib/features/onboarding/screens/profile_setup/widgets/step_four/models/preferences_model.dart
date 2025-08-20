
// File: lib/features/preferences/models/preference_models.dart
class PreferenceData {
  final String language;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool interviewReminders;
  final bool weeklyReports;
  final String preferredInterviewTime;
  final String experienceLevel;

  const PreferenceData({
    required this.language,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.interviewReminders,
    required this.weeklyReports,
    required this.preferredInterviewTime,
    required this.experienceLevel,
  });

  factory PreferenceData.initial() {
    return const PreferenceData(
      language: 'English',
      emailNotifications: true,
      pushNotifications: true,
      interviewReminders: true,
      weeklyReports: false,
      preferredInterviewTime: 'Morning (9 AM - 12 PM)',
      experienceLevel: 'Intermediate (2-5 years)',
    );
  }

  factory PreferenceData.fromMap(Map<String, dynamic> map) {
    return PreferenceData(
      language: map['language'] ?? 'English',
      emailNotifications: map['emailNotifications'] ?? true,
      pushNotifications: map['pushNotifications'] ?? true,
      interviewReminders: map['interviewReminders'] ?? true,
      weeklyReports: map['weeklyReports'] ?? false,
      preferredInterviewTime: map['preferredInterviewTime'] ?? 'Morning (9 AM - 12 PM)',
      experienceLevel: map['experienceLevel'] ?? 'Intermediate (2-5 years)',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'interviewReminders': interviewReminders,
      'weeklyReports': weeklyReports,
      'preferredInterviewTime': preferredInterviewTime,
      'experienceLevel': experienceLevel,
    };
  }

  PreferenceData copyWith({
    String? language,
    bool? emailNotifications,
    bool? pushNotifications,
    bool? interviewReminders,
    bool? weeklyReports,
    String? preferredInterviewTime,
    String? experienceLevel,
  }) {
    return PreferenceData(
      language: language ?? this.language,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      interviewReminders: interviewReminders ?? this.interviewReminders,
      weeklyReports: weeklyReports ?? this.weeklyReports,
      preferredInterviewTime: preferredInterviewTime ?? this.preferredInterviewTime,
      experienceLevel: experienceLevel ?? this.experienceLevel,
    );
  }
}

// File: lib/features/preferences/constants/preference_constants.dart
class PreferenceConstants {
  static const List<String> languages = [
    'English', 'Spanish', 'French', 'German',
    'Chinese', 'Japanese', 'Hindi', 'Arabic'
  ];

  static const List<String> interviewTimes = [
    'Morning (9 AM - 12 PM)',
    'Afternoon (12 PM - 5 PM)',
    'Evening (5 PM - 9 PM)',
    'Flexible'
  ];

  static const List<String> experienceLevels = [
    'Beginner (0-2 years)',
    'Intermediate (2-5 years)',
    'Senior (5-10 years)',
    'Expert (10+ years)'
  ];
}