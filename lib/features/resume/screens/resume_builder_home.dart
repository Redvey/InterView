import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/features/resume/screens/personal_details_form/personal_details_form.dart';
import 'package:interview/features/resume/screens/projects_form/projects_form.dart';
import 'package:interview/features/resume/screens/roles_form/roles_form.dart';
import 'package:interview/features/resume/screens/skill_form/skill_form.dart';
import 'package:interview/features/resume/screens/social_links_form/social_links_form.dart';
import 'package:interview/features/resume/widgets/page_indicator.dart';
import '../../../core/utils/color_utils.dart';
import 'achievements_form/achievements_form.dart';
import 'contact_form/contact_form.dart';
import 'education_form/education_form.dart';
import 'experience_form/experience_form.dart';
import 'other_form/other_form.dart';

class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({super.key});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 10;

  Color _getPageColor(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return AppColors.generalInformation;
      case 1:
        return AppColors.contactForm;
      case 2:
        return AppColors.educationForm;
      case 3:
        return AppColors.skillForm;
      case 4:
        return AppColors.rolesForm;
      case 5:
        return AppColors.projectForm;
      case 6:
        return AppColors.socialForm;
      case 7:
        return AppColors.jobForm;
      case 8:
        return AppColors.achievementsForm;
      case 9:
        return AppColors.otherForm;
      default:
        return AppColors.purple;
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Final Step"),
            content: const Text("Have you filled in all your details correctly?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push('/final');
                },
                child: const Text("Yes, Proceed"),
              ),
            ],
          );
        },
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    CircleAvatar(radius: 15,)
                  ],
                ),
                SizedBox(height: AppSizes.spaceBtwItems-10),
                PageIndicator(
                  pageController: _pageController,
                  totalPages: _totalPages,
                  activeDotColor: getMatchingHintColor(
                    _getPageColor(_currentPage),
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      const GeneralInformation(),
                      const ContactForm(),
                      const EducationForm(),
                      const SkillForm(),
                      const OpenToRolesForm(),
                      const ProjectsForm(),
                      const SocialLinksForm(),
                      const WorkExperienceForm(),
                      const AchievementsForm(),
                      const OtherInformationForm(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        GestureDetector(
                          onTap: _previousPage,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.blackLight,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.backgroundLightOrange,
                              size: AppSizes.buttonHeight,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: _nextPage,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.blackLight,
                          child: Icon(
                            _currentPage == _totalPages - 1
                                ? Icons.check
                                : Icons.arrow_forward_ios,
                            color: AppColors.backgroundLime,
                            size: AppSizes.buttonHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
