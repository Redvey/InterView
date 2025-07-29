import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../core/constants/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isProfileMenuOpen;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isProfileMenuOpen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: context.bottomNavBottomPadding),
        child: Container(
          height: context.bottomNavHeight,
          margin: EdgeInsets.symmetric(horizontal: context.spaceLess),
          padding: EdgeInsets.symmetric(horizontal: context.bottomNavHorizontalPadding),
          decoration: BoxDecoration(
            color: AppColors.bottomBlack,
            borderRadius: BorderRadius.circular(context.bottomNavRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.bottomNavShadowAlpha,
                blurRadius: context.bottomNavShadowBlur,
                offset: Offset(context.zero, context.bottomNavShadowOffsetY),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavIcon(
                icon: Icons.home,
                label: AppStrings.navHome,
                selected: currentIndex == 0 && !isProfileMenuOpen, 
                selectedColor: AppColors.textGreen,
                onTap: () => onTap(0),
              ),
              NavIcon(
                icon: Icons.interests_rounded,
                label: AppStrings.navInterviews,
                selected: currentIndex == 1 && !isProfileMenuOpen, 
                selectedColor: AppColors.backgroundLightPink,
                onTap: () => onTap(1),
              ),
              NavIcon(
                icon: Icons.flash_on_sharp,
                label: AppStrings.navFlashCards,
                selected: currentIndex == 2 && !isProfileMenuOpen,
                selectedColor: AppColors.backgroundYellow,
                onTap: () => onTap(2),
              ),
              // Profile tab with special handling
              NavIcon(
                icon: Icons.person_rounded,
                label: AppStrings.navProfile,
                selected: false, // Never selected, always shows overlay
                selectedColor: AppColors.textBlueBg,
                onTap: () => onTap(3),
                isProfileTab: true,
                isProfileMenuOpen: isProfileMenuOpen, // Pass the menu state
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavIcon extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;
  final String label;
  final bool isProfileTab;
  final bool isProfileMenuOpen;

  const NavIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
    this.isProfileTab = false,
    this.isProfileMenuOpen = false,
  });

  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _scaleAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _tapController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isTapped = true);
    _tapController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _handleTapEnd();
  }

  void _handleTapCancel() {
    _handleTapEnd();
  }

  void _handleTapEnd() {
    setState(() => _isTapped = false);
    _tapController.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {

    final isProfileActive = widget.isProfileTab && widget.isProfileMenuOpen;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: Duration(milliseconds: context.navAnimationDuration),
              curve: Curves.easeOut,
              padding: widget.selected || isProfileActive
                  ? EdgeInsets.symmetric(
                horizontal: context.navIconPaddingHorizontal,
                vertical: context.navIconPaddingVertical,
              )
                  : EdgeInsets.all(context.navIconPaddingVertical),
              decoration: BoxDecoration(
                border: Border.all(
                  width: context.borderWidthThin,
                  color: (widget.isProfileTab && _isTapped) || isProfileActive
                      ? widget.selectedColor.withAlpha(127)
                      : AppColors.blackLight,
                ),
                color: widget.selected || isProfileActive
                    ? AppColors.bottomBlackLight
                    : widget.isProfileTab && _isTapped
                    ? AppColors.bottomBlackLight.withAlpha(178)
                    : AppColors.bottomBlack.withAlpha(76),
                borderRadius: widget.selected || isProfileActive
                    ? BorderRadius.circular(context.navIconBorderRadius)
                    : BorderRadius.circular(100),
                boxShadow: (widget.isProfileTab && _isTapped) || isProfileActive
                    ? [
                  BoxShadow(
                    color: widget.selectedColor.withAlpha(isProfileActive ? 102 : 76),

                  ),
                ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.selected || isProfileActive
                        ? widget.selectedColor
                        : widget.isProfileTab && _isTapped
                        ? widget.selectedColor
                        : AppColors.bottomGrey,
                    size: widget.selected || isProfileActive
                        ? context.navIconSizeSelected
                        : context.navIconSizeUnselected,
                  ),
                  // Show animated label when selected OR when profile menu is open
                  if (widget.selected || isProfileActive) ...[
                    AnimatedSize(
                      duration: Duration(milliseconds: context.navAnimationDuration),
                      curve: Curves.easeInOut,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: context.navAnimationDuration),
                        opacity: 1.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: context.navLabelPaddingLeft),
                          child: Text(
                            widget.label,
                            style: AppTextStyles.navTextStyle(context, widget.selectedColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}