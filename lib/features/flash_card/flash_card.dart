import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/constants/strings.dart';
import '../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  String? selectedTopic;

  final List<String> programmingLanguages = [
    'Python', 'Java', 'Javascript', 'C++', 'C#', 'Ruby', 'Swift', 'Kotlin', 'Go', 'Rust', 'TypeScript', 'PHP', 'HTML', 'CSS',
  ];

  final List<String> mobileDevelopment = [
    'React Native', 'Flutter', 'iOS SDK', 'Android SDK',
  ];

  final List<String> webDevelopment = [
    'MERN', 'Node.js', 'Next.js', 'React', 'Angular', 'Vue.js', 'Django', 'Flask', 'Ruby on Rails', 'Express.js', 'Spring Boot', 'Laravel',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.all(AppSizes.lg(context)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ResumeFormTopBar(pageColor: AppColors.blackLight, title: AppStrings.flashcard,),
                  const SizedBox(height: 16),

                  const Text("Practice Cards", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  const SizedBox(height: 12),

                  const Text("Programming Languages", style: TextStyle(fontWeight: FontWeight.w600)),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: programmingLanguages.map((topic) => _buildChip(topic, selectedTopic, (val) {
                      setState(() => selectedTopic = val);
                    })).toList(),
                  ),

                  const SizedBox(height: 16),
                  const Text("Mobile Development", style: TextStyle(fontWeight: FontWeight.w600)),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: mobileDevelopment.map((topic) => _buildChip(topic, selectedTopic, (val) {
                      setState(() => selectedTopic = val);
                    })).toList(),
                  ),

                  const SizedBox(height: 16),
                  const Text("Web Development", style: TextStyle(fontWeight: FontWeight.w600)),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: webDevelopment.map((topic) => _buildChip(topic, selectedTopic, (val) {
                      setState(() => selectedTopic = val);
                    })).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar {
  const ProfileAvatar();
}

Widget _buildChip(String label, String? selectedValue, Function(String) onSelected) {
  final bool isSelected = selectedValue == label;

  return ChoiceChip(
    label: Text(label),
    selected: isSelected,
    onSelected: (_) => onSelected(label),
    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    selectedColor: Colors.black,
    backgroundColor: Colors.white,
    shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade400)),
    showCheckmark: false,
  );
}
