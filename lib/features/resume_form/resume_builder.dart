import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/features/resume_form/achievements_form.dart';
import 'package:interview/features/resume_form/contact_form.dart';
import 'package:interview/features/resume_form/education_form.dart';
import 'package:interview/features/resume_form/experience_form.dart';
import 'package:interview/features/resume_form/other_form.dart';
import 'package:interview/features/resume_form/personal_details_form.dart';
import 'package:interview/features/resume_form/projects_form.dart';
import 'package:interview/features/resume_form/roles_form.dart';
import 'package:interview/features/resume_form/skill_form.dart';
import 'package:interview/features/resume_form/social_links_form.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({super.key});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final int _totalPages = 10;

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
                IconButton(onPressed: ()=>context.pop(), icon: Icon(Icons.arrow_back_ios)),
                //
                // Text(AppStrings.buildYourResume,style: AppTextStyles.heading,),
                // SizedBox(height: AppSizes.spaceBtwItems,),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _totalPages,
                    effect: ExpandingDotsEffect(),
                    onDotClicked: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     'Step ${_currentPage + 1} of $_totalPages',
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                // ),
                // SizedBox(height: AppSizes.spaceBtwItems,),
                // PageView
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
                  ),
                ),
            
                // Navigation Buttons
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

                            child:  Icon(
                              Icons.arrow_back_ios,size: AppSizes.buttonHeight,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: _nextPage,
                        child: CircleAvatar(
                          radius: 30,

                          child:  Icon(size: AppSizes.buttonHeight,
                            _currentPage == _totalPages - 1 ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
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
