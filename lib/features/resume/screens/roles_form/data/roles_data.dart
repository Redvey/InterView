import 'package:flutter/material.dart';
import '../../widgets/model/selectable_item.dart';


final Map<String, List<SelectableItem>> roleData = {
  'Programming Languages': [
    SelectableItem(name: 'Software Engineer', icon: Icons.laptop_mac),
    SelectableItem(name: 'Backend Developer', icon: Icons.storage),
    SelectableItem(name: 'Frontend Developer', icon: Icons.desktop_windows),
    SelectableItem(name: 'Full Stack Developer', icon: Icons.layers),
    SelectableItem(name: 'System Programmer', icon: Icons.memory),
  ],

  'Mobile Development': [
    SelectableItem(name: 'Mobile App Developer', icon: Icons.smartphone),
    SelectableItem(name: 'Android Developer', icon: Icons.android),
    SelectableItem(name: 'iOS Developer', icon: Icons.phone_iphone),
    SelectableItem(name: 'Flutter Developer', icon: Icons.flutter_dash),
  ],

  'Web Development': [
    SelectableItem(name: 'Web Developer', icon: Icons.language),
    SelectableItem(name: 'Frontend Developer', icon: Icons.web_asset),
    SelectableItem(name: 'Backend Developer', icon: Icons.settings),
    SelectableItem(name: 'Full Stack Developer', icon: Icons.integration_instructions),
    SelectableItem(name: 'Node.js Developer', icon: Icons.cloud),
    SelectableItem(name: 'React Developer', icon: Icons.replay),
    SelectableItem(name: 'Express.js Developer', icon: Icons.route),
  ],

  'Artificial Intelligence': [
    SelectableItem(name: 'Machine Learning Engineer', icon: Icons.memory),
    SelectableItem(name: 'AI Engineer', icon: Icons.psychology),
    SelectableItem(name: 'Data Scientist', icon: Icons.analytics),
    SelectableItem(name: 'Data Analyst', icon: Icons.bar_chart),
  ],
};
