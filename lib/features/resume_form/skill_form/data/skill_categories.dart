import 'package:flutter/material.dart';

import '../model/skill_item.dart';

final Map<String, List<SkillItem>> skillCategories = {
  'Programming Languages': [
    SkillItem(name: 'Python', icon: Icons.code),
    SkillItem(name: 'Java', icon: Icons.computer),
    SkillItem(name: 'Javascript', icon: Icons.javascript),
    SkillItem(name: 'C++', icon: Icons.memory),
    SkillItem(name: 'TypeScript', icon: Icons.developer_mode),
  ],
  'Mobile Development': [
    SkillItem(name: 'Flutter', icon: Icons.phone_android),
    SkillItem(name: 'Android SDK (Kotlin)', icon: Icons.android),
  ],
  'Web Development': [
    SkillItem(name: 'Node.js', icon: Icons.cloud),
    SkillItem(name: 'React', icon: Icons.web),
    SkillItem(name: 'Express.js', icon: Icons.rocket_launch),
  ],
  'Artificial Intelligence': [
    SkillItem(name: 'Machine Learning', icon: Icons.memory),
    SkillItem(name: 'Deep Learning', icon: Icons.device_hub),
    SkillItem(name: 'NLP', icon: Icons.language),
    SkillItem(name: 'Computer Vision', icon: Icons.remove_red_eye),
    SkillItem(name: 'TensorFlow', icon: Icons.track_changes),
    SkillItem(name: 'PyTorch', icon: Icons.bolt),
    SkillItem(name: 'Scikit-Learn', icon: Icons.science),
    SkillItem(name: 'NLTK', icon: Icons.text_fields),
  ],
};
