import 'package:flutter/material.dart';
import '../../widgets/model/selectable_item.dart';

final Map<String, List<SelectableItem>> skillData = {
  'Programming Languages': [
    SelectableItem(name: 'Python', icon: Icons.code),
    SelectableItem(name: 'Java', icon: Icons.computer),
    SelectableItem(name: 'Javascript', icon: Icons.javascript),
    SelectableItem(name: 'C++', icon: Icons.memory),
    SelectableItem(name: 'TypeScript', icon: Icons.developer_mode),
  ],
  'Mobile Development': [
    SelectableItem(name: 'Flutter', icon: Icons.phone_android),
    SelectableItem(name: 'Android SDK (Kotlin)', icon: Icons.android),
  ],
  'Web Development': [
    SelectableItem(name: 'Node.js', icon: Icons.cloud),
    SelectableItem(name: 'React', icon: Icons.web),
    SelectableItem(name: 'Express.js', icon: Icons.rocket_launch),
  ],
  'Artificial Intelligence': [
    SelectableItem(name: 'Machine Learning', icon: Icons.memory),
    SelectableItem(name: 'Deep Learning', icon: Icons.device_hub),
    SelectableItem(name: 'NLP', icon: Icons.language),
    SelectableItem(name: 'Computer Vision', icon: Icons.remove_red_eye),
    SelectableItem(name: 'TensorFlow', icon: Icons.track_changes),
    SelectableItem(name: 'PyTorch', icon: Icons.bolt),
    SelectableItem(name: 'Scikit-Learn', icon: Icons.science),
    SelectableItem(name: 'NLTK', icon: Icons.text_fields),
  ],
};
