import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/resume/widgets/final_step_dialog.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_bottom_buttons.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_pages.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
import 'package:interview/features/resume/widgets/page_indicator.dart';
import '../../../app/routes/route_names.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/color_utils.dart';

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
        builder: (BuildContext context) => const FinalStepDialog(
          title: AppStrings.alertTitle,
          subTitle: AppStrings.alertSubTitle,
          yes: AppStrings.alertYes,
          no: AppStrings.alertNo,
          routeName: RouteNames.finalResume,
        ),
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
        child: SafeArea(
          child: Padding(
            padding: context.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeFormTopBar(
                  pageColor: _getPageColor(_currentPage),
                  title: AppStrings.resumeBuilder,
                ),

                SizedBox(height: context.defaultSpace),
                PageIndicator(
                  pageController: _pageController,
                  totalPages: _totalPages,
                  activeDotColor: getMatchingHintColor(
                    _getPageColor(_currentPage),
                  ),
                ),
                SizedBox(height: context.defaultSpace),
                Expanded(
                  child: ResumeFormPages(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                  ),
                ),
                ResumeFormBottomButtons(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  onNext: _nextPage,
                  onPrevious: _previousPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
