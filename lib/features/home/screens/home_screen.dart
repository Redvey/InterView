import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/home/widgets/welcome_message.dart';
import 'package:interview/features/reports/interview_reports.dart';
import '../../../core/utils/helper_functions.dart';
import '../../reports/flash_card_reports.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../widgets/animated_wrapper.dart';
import '../animation/home_animation_manager.dart';
import '../widgets/feature_list.dart';
import '../widgets/welcome_card.dart';
import 'package:interview/features/profile/widgets/liquid_menu_overlay.dart';
import 'package:interview/features/profile/data/models/menu_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _showMenu = false;

  Widget _buildCurrentPageSnapshot() {
    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  late AnimationController _controller;
  late AnimationController _bottomNavController;
  late HomeAnimationManager _animationManager;
  late Animation<Offset> _bottomNavSlideAnimation;
  late Animation<double> _bottomNavFadeAnimation;

  // Track current tab and animation state
  int _selectedIndex = 0;
  bool _hasPlayedEntranceAnimation = false;

  // Page controller for smooth tab transitions
  late PageController _pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _bottomNavController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animationManager = HomeAnimationManager(_controller);

    _bottomNavSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _bottomNavController,
            curve: Curves.easeOutCubic,
          ),
        );

    _bottomNavFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bottomNavController, curve: Curves.easeOut),
    );

    // Play entrance animation only once
    if (!_hasPlayedEntranceAnimation) {
      _playEntranceAnimation();
      _hasPlayedEntranceAnimation = true;
    }
  }

  void _playEntranceAnimation() {
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _bottomNavController.forward();
      }
    });
  }

  void _onTabSelected(int index) {
    if (index == 3) {
      // Profile tab - show overlay but don't change selected index
      // This keeps the previously selected tab highlighted
      setState(() => _showMenu = true);
      return;
    }

    // For other tabs, close menu if open and switch tab
    setState(() {
      _selectedIndex = index;
      if (_showMenu) {
        _showMenu = false;
      }
    });

    // Smooth page transition
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _bottomNavController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: [
                  _buildHomeTab(),
                  _buildInterviewsTab(),
                  _buildFlashCardsTab(),
                ],
              ),
            ),
          ),

          // Liquid menu overlay inside stack
          if (_showMenu)
            LiquidMenuOverlay(
              backgroundWidget: _buildCurrentPageSnapshot(),
              userName: "Roopam",
              // Use the correct menu items from menu data instead of hardcoded values
              menuItems: defaultMenuItems, // This should contain the updated menu items
              onClose: () => setState(() => _showMenu = false),
              onMenuItemTap: (item) {
                handleProfileMenuItemTap(context, item);
                // Only close menu if it's not logout (logout dialog handles its own overlay cleanup)
                if (item != 'Logout') {
                  setState(() => _showMenu = false);
                }
              },
            ),

          // Animated bottom navigation
          SlideTransition(
            position: _bottomNavSlideAnimation,
            child: FadeTransition(
                opacity: _bottomNavFadeAnimation,
                child: CustomBottomNav(
                  currentIndex: _selectedIndex,
                  onTap: _onTabSelected,
                  isProfileMenuOpen: _showMenu,
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          SizedBox(height: context.spaceBtwSections),
          _buildWelcomeCard(),
          SizedBox(height: context.defaultSpaceH),
          _buildFeaturesList(),
          SizedBox(height: context.bottomNavHeight + 20),
          // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildInterviewsTab() {
    return InterviewReportsScreen();
  }

  Widget _buildFlashCardsTab() {
    return FlashCardsHistoryScreen();
  }

  Widget _buildWelcomeSection() {
    return AnimatedContentWrapper(
      fadeAnimation: _animationManager
          .fadeAnimations[AppStrings.welcomeMessageAnimationIndex],
      slideAnimation: _animationManager
          .slideAnimations[AppStrings.welcomeMessageAnimationIndex],
      child: WelcomeMessage(
        onProfileTap: () => setState(() => _showMenu = true), // Add this callback
      ),
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
}