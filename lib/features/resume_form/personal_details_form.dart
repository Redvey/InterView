import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import '../../core/constants/colors.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.generalInformation,

          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              Text(AppStrings.firstName),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.hintFirstName,
                ),
              ),
              const SizedBox(height: 16),

              // Last Name
              Text(AppStrings.lastName),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.lastName,
                ),
              ),
              const SizedBox(height: 16),

              // Short Bio
              Text(AppStrings.shortBio),
              const SizedBox(height: 8),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.bio,
                ),
              ),
              const SizedBox(height: 16),

              // Years of Experience
              Text(AppStrings.yearsOfExperience),
              const SizedBox(height: 8),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.experience,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
