import 'package:flutter/material.dart';

class SkillController {
  List<String> skills = [];
  final TextEditingController skillController = TextEditingController();

  void addSkill(String skill, VoidCallback refresh) {
    final trimmed = skill.trim();
    if (trimmed.isEmpty || skills.contains(trimmed)) return;
    skills.add(trimmed);
    refresh();
    skillController.clear();
  }

  void removeSkill(String skill, VoidCallback refresh) {
    skills.remove(skill);
    refresh();
  }

  void setSkills(List<String> newSkills) {
    skills = newSkills;
    skillController.clear();
  }

  bool isSelected(String skill) => skills.contains(skill);

  void toggleSkill(String skill, VoidCallback refresh) {
    if (isSelected(skill)) {
      removeSkill(skill, refresh);
    } else {
      if (skills.length >= 12) return;
      skills.add(skill);
      refresh();
    }
  }

  void clear() {
    skills.clear();
    skillController.clear();
  }
}
