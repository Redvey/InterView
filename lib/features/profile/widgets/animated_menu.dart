import 'package:flutter/material.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

/// A widget that displays a menu item with animated slide-in effect
class AnimatedMenuItem extends StatelessWidget {
  final String text;
  final int index;
  final bool showMenu;
  final VoidCallback? onTap;

  const AnimatedMenuItem({
    super.key,
    required this.text,
    required this.index,
    required this.showMenu,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000 + index * 50),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          showMenu ? 0 : -500 - (index * 20).toDouble(), // Slide in from left
          0,
          0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Semantics(
            label: text, button: onTap != null,
            child: Text(
              text,
              style: TextStyle(fontFamily: AppFonts.poppins,color: AppColors.backgroundYellow,fontSize: context.fontSizeSd),
            ),
          ),
        ),
      ),
    );
  }
}
