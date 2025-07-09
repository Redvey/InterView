import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class EducationForm extends StatelessWidget {
  const EducationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.educationForm,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Institution Name
              const Text('Institution Name'),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter institution name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Course Name
              const Text('Course Name'),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter course name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Score
              const Text('Score'),
              const SizedBox(height: 8),
              const TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Enter score (CGPA or %)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Passing Year
              const Text('Passing Year'),
              const SizedBox(height: 8),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter passing year',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Add Education Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add logic to append another education form section
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Education'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
