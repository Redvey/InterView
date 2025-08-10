import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/features/onboarding/screens/onboarding/widgets/constants_onboarding.dart';
import 'package:interview/features/onboarding/screens/onboarding/widgets/onboarding_background.dart';
import 'package:interview/features/onboarding/screens/onboarding/widgets/onboarding_top_bar.dart';
import 'package:interview/features/onboarding/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:interview/features/onboarding/screens/onboarding/widgets/onboarding_page_content.dart';
import 'package:interview/features/onboarding/services/auth_service.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _skipOnboarding() async {
    await AuthService.completeOnboarding();
    if (mounted) context.go('/auth');
  }

  void _completeOnboarding() async {
    await AuthService.completeOnboarding();
    if (mounted) context.go('/home');
  }

  void _nextPage() {
    if (_currentIndex == OnboardingConstants.onboardingPages.length - 1) {
      _completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: OnboardingConstants.pageGradients[_currentIndex],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              // Background Image
              OnboardingBackground(
                currentPage: _currentPage,
              ),

              Column(
                children: [
                  // Top section with Skip button and Page Indicator
                  OnboardingTopBar(
                    pageController: _pageController,
                    onboardingPagesCount: OnboardingConstants.onboardingPages.length,
                    onSkip: _skipOnboarding,
                  ),

                  // Content section (expandable)
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: OnboardingConstants.onboardingPages.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (_, index) => OnboardingPageContent(
                        data: OnboardingConstants.onboardingPages[index],
                      ),
                    ),
                  ),

                  // Bottom navigation with concentric circular buttons
                  OnboardingBottomNavigation(
                    currentIndex: _currentIndex,
                    totalPages: OnboardingConstants.onboardingPages.length,
                    onNextPressed: _nextPage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}