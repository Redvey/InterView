import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/utils/color_utils.dart';
import 'package:interview/features/resume/widgets/dotted_button.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';

import '../../../../core/constants/colors.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({super.key});

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final List<int> _entryIds = [];

  @override
  void initState() {
    super.initState();
    _addEducationEntry(); // Initial entry
  }

  void _addEducationEntry() {
    setState(() {
      _entryIds.add(DateTime.now().millisecondsSinceEpoch); // Unique key
    });
  }

  void _removeEducationEntry(int index) {
    setState(() {
      _entryIds.removeAt(index);
    });
  }

  Widget _buildEducationEntry(int index, Color containerColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.educationForm,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('First educational entry...', style: TextStyle(fontSize: 14)),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _removeEducationEntry(index),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LabeledTextField(
            label: 'Institution Name',
            hint: 'Enter institution name',
            containerColor: containerColor,
          ),
          const SizedBox(height: 16),
          LabeledTextField(
            label: 'Course Name',
            hint: 'Enter course name',
            containerColor: containerColor,
          ),
          const SizedBox(height: 16),
          LabeledTextField(
            label: 'Score',
            hint: 'Enter score (CGPA or %)',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            containerColor: containerColor,
          ),
          const SizedBox(height: 16),
          LabeledTextField(
            label: 'Passing Year',
            hint: 'Enter passing year',
            keyboardType: TextInputType.number,
            containerColor: containerColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color containerColor = darkerEducationColor;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Education Entry', style: AppTextStyles.infoHeader),
              const SizedBox(height: 16),
              ..._entryIds.asMap().entries.map(
                (entry) => _buildEducationEntry(entry.key, containerColor),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _addEducationEntry,
                  child: DottedBorderButton(detail: "Add Education"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
