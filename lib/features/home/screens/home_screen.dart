import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/home/widgets/welcome_message.dart';

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
  late HomeAnimationManager _animationManager;

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

    _animationManager = HomeAnimationManager(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
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
                _buildAdSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return AnimatedContentWrapper(
      fadeAnimation: _animationManager.fadeAnimations[AppStrings.welcomeMessageAnimationIndex],
      slideAnimation: _animationManager.slideAnimations[AppStrings.welcomeMessageAnimationIndex],
      child: const WelcomeMessage(),
    );
  }

  Widget _buildWelcomeCard() {
    return AnimatedContentWrapper(
      fadeAnimation: _animationManager.fadeAnimations[AppStrings.welcomeCardAnimationIndex],
      slideAnimation: _animationManager.slideAnimations[AppStrings.welcomeCardAnimationIndex],
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
      fadeAnimation: _animationManager.fadeAnimations[AppStrings.adSectionAnimationIndex],
      slideAnimation: _animationManager.slideAnimations[AppStrings.adSectionAnimationIndex],
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