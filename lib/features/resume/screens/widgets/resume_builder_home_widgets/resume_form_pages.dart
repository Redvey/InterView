import 'package:flutter/material.dart';
import 'package:interview/features/resume/screens/achievements_form/achievements_form.dart';
import 'package:interview/features/resume/screens/contact_form/contact_form.dart';
import 'package:interview/features/resume/screens/education_form/education_form.dart';
import 'package:interview/features/resume/screens/experience_form/experience_form.dart';
import 'package:interview/features/resume/screens/other_form/other_form.dart';
import 'package:interview/features/resume/screens/personal_details_form/personal_details_form.dart';
import 'package:interview/features/resume/screens/projects_form/projects_form.dart';
import 'package:interview/features/resume/screens/roles_form/roles_form.dart';
import 'package:interview/features/resume/screens/skill_form/skill_form.dart';
import 'package:interview/features/resume/screens/social_links_form/social_links_form.dart';

class ResumeFormPages extends StatelessWidget {
  final PageController controller;
  final Function(int) onPageChanged;

  const ResumeFormPages({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: onPageChanged,
      children: const [
        GeneralInformation(),
        ContactForm(),
        EducationForm(),
        SkillForm(),
        OpenToRolesForm(),
        ProjectsForm(),
        SocialLinksForm(),
        WorkExperienceForm(),
        AchievementsForm(),
        OtherInformationForm(),
      ],
    );
  }
}
