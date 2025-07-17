import 'package:flutter/material.dart';

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
        duration: Duration(milliseconds: 1000 + index * 50), // Staggered timing
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          showMenu ? 0 : -500 - (index * 20).toDouble(), // Slide in from left
          0,
          0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}