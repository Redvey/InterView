import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import '../../../core/constants/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
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
                selected: currentIndex == 0,
                selectedColor: AppColors.textGreen,
                onTap: () => onTap(0),
              ),
              NavIcon(
                icon: Icons.interests_rounded,
                label: AppStrings.navInterviews,
                selected: currentIndex == 1,
                selectedColor: AppColors.backgroundLightPink,
                onTap: () => onTap(1),
              ),
              NavIcon(
                icon: Icons.flash_on_sharp,
                label: AppStrings.navFlashCards,
                selected: currentIndex == 2,
                selectedColor: AppColors.backgroundYellow,
                onTap: () => onTap(2),
              ),
              NavIcon(
                icon: Icons.person_rounded,
                label: AppStrings.navProfile,

                selected: currentIndex == 3,
                selectedColor: AppColors.textBlueBg,
                onTap: () => onTap(3),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;
  final String label;

  const NavIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: context.navAnimationDuration),
        curve: Curves.easeOut,
        padding: selected
            ? EdgeInsets.symmetric(
          horizontal: context.navIconPaddingHorizontal,
          vertical: context.navIconPaddingVertical,
        )
            : EdgeInsets.all(context.navIconPaddingVertical), // Use equal padding for circular shape
        decoration: BoxDecoration(
          border: Border.all(
            width: context.borderWidthThin,
            color: AppColors.blackLight,
          ),
          color: selected ? AppColors.bottomBlackLight : AppColors.bottomBlack.withAlpha(76),
          borderRadius: selected
              ? BorderRadius.circular(context.navIconBorderRadius)
              : BorderRadius.circular(100), // Make it fully circular when unselected
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? selectedColor : AppColors.bottomGrey,
              size: selected ? context.navIconSizeSelected : context.navIconSizeUnselected,
            ),
            // Only render the animated label section when selected
            if (selected) ...[
              AnimatedSize(
                duration: Duration(milliseconds: context.navAnimationDuration),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: context.navAnimationDuration),
                  opacity: 1.0,
                  child: Padding(
                    padding: EdgeInsets.only(left: context.navLabelPaddingLeft),
                    child: Text(
                      label,
                      style: AppTextStyles.navTextStyle(context,selectedColor),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}