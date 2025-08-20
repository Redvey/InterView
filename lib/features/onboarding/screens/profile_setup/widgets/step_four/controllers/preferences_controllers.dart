import 'package:flutter/material.dart';
import '../models/preferences_model.dart';

class PreferenceController extends ChangeNotifier {
  PreferenceData _preferenceData = PreferenceData.initial();

  PreferenceData get preferenceData => _preferenceData;

  void initializeFromMap(Map<String, dynamic> initialData) {
    _preferenceData = PreferenceData.fromMap(initialData);
    notifyListeners();
  }

  void updateLanguage(String language) {
    if (PreferenceConstants.languages.contains(language)) {
      _preferenceData = _preferenceData.copyWith(language: language);
      notifyListeners();
    }
  }

  void updateEmailNotifications(bool value) {
    _preferenceData = _preferenceData.copyWith(emailNotifications: value);
    notifyListeners();
  }

  void updatePushNotifications(bool value) {
    _preferenceData = _preferenceData.copyWith(pushNotifications: value);
    notifyListeners();
  }

  void updateInterviewReminders(bool value) {
    _preferenceData = _preferenceData.copyWith(interviewReminders: value);
    notifyListeners();
  }

  void updateWeeklyReports(bool value) {
    _preferenceData = _preferenceData.copyWith(weeklyReports: value);
    notifyListeners();
  }

  void updatePreferredInterviewTime(String time) {
    if (PreferenceConstants.interviewTimes.contains(time)) {
      _preferenceData = _preferenceData.copyWith(preferredInterviewTime: time);
      notifyListeners();
    }
  }

  void updateExperienceLevel(String level) {
    if (PreferenceConstants.experienceLevels.contains(level)) {
      _preferenceData = _preferenceData.copyWith(experienceLevel: level);
      notifyListeners();
    }
  }
}
