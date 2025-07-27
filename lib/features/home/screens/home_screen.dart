import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/home/widgets/welcome_message.dart';
import 'package:interview/features/widgets/bottom_nav_wrapper.dart';
import '../widgets/animated_wrapper.dart';
import '../animation/home_animation_manager.dart';
import '../widgets/feature_list.dart';
import '../widgets/welcome_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bottomNavController;
  late HomeAnimationManager _animationManager;
  late Animation<Offset> _bottomNavSlideAnimation;
  late Animation<double> _bottomNavFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Bottom nav animation controller with slower, synced timing
    _bottomNavController = AnimationController(
      duration: const Duration(milliseconds: 1200), // Match main controller duration
      vsync: this,
    );

    _animationManager = HomeAnimationManager(_controller);

    // Bottom nav animations - slower and more subtle
    _bottomNavSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0), // Less dramatic starting position
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bottomNavController,
      curve: Curves.easeOutCubic,
    ));

    _bottomNavFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bottomNavController,
      curve: Curves.easeOut,
    ));


    _controller.forward();


    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _bottomNavController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _bottomNavController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: context.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    SizedBox(height: context.spaceBtwSections),
                    _buildWelcomeCard(),
                    SizedBox(height: context.defaultSpaceH),
                    _buildFeaturesList(),
                    // _buildAdSection(),
                  ],
                ),
              ),
            ),
          ),

          // Animated bottom navigation
          SlideTransition(
            position: _bottomNavSlideAnimation,
            child: FadeTransition(
              opacity: _bottomNavFadeAnimation,
              child: MyBottomNavWrapper(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return AnimatedContentWrapper(
      fadeAnimation: _animationManager
          .fadeAnimations[AppStrings.welcomeMessageAnimationIndex],
      slideAnimation: _animationManager
          .slideAnimations[AppStrings.welcomeMessageAnimationIndex],
      child: const WelcomeMessage(),
    );
  }

  Widget _buildWelcomeCard() {
    return AnimatedContentWrapper(
      fadeAnimation: _animationManager
          .fadeAnimations[AppStrings.welcomeCardAnimationIndex],
      slideAnimation: _animationManager
          .slideAnimations[AppStrings.welcomeCardAnimationIndex],
      child: const WelcomeCard(),
    );
  }

  Widget _buildFeaturesList() {
    return AnimatedFeatureList(
      animationManager: _animationManager,
      startIndex: AppStrings.featuresListStartIndex,
    );
  }

  Widget _buildAdSection() {
    return AnimatedContentWrapper(
      fadeAnimation:
      _animationManager.fadeAnimations[AppStrings.adSectionAnimationIndex],
      slideAnimation:
      _animationManager.slideAnimations[AppStrings.adSectionAnimationIndex],
      child: Column(
        children: [
          Divider(thickness: context.dividerHeight),
          SizedBox(height: context.defaultSpaceH),
          Container(
            height: context.adCard,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.borderRadiusLg),
              gradient: AppColors.backgroundGradient,
            ),
            child: Center(
              child: Text(AppStrings.ad, style: context.welcomeStyle),
            ),
          ),
        ],
      ),
    );
  }
}