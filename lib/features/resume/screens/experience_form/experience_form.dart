import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/resume/screens/experience_form/experience_entry_model.dart';
import 'package:interview/features/resume/screens/experience_form/widgets/experience_card.dart';
import 'package:interview/features/resume/widgets/dotted_button.dart';

class WorkExperienceForm extends StatefulWidget {
  const WorkExperienceForm({super.key});

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  final List<ExperienceEntry> _experiences = [];

  void _addExperience() {
    setState(() {
      _experiences.add(ExperienceEntry());
    });
  }

  void _removeExperience(int index) {
    setState(() {
      _experiences.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var exp in _experiences) {
      exp.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.jobForm,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.workExperience, style:  context.infoHeaderStyle),
              const SizedBox(height: 16),
              ..._experiences.asMap().entries.map((entry) {
                final index = entry.key;
                return ExperienceCard(
                  key: ValueKey(index),
                  experience: entry.value,
                  onRemove: () => _removeExperience(index),
                );
              }),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _addExperience,
                child: DottedBorderButton(detail: AppStrings.addExperience),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
