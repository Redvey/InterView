import 'package:flutter/material.dart';
import 'custom_bottom_nav.dart';

// This wrapper is now optional since tab management is handled in HomeScreen
// But kept for backward compatibility if needed elsewhere
class MyBottomNavWrapper extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavWrapper({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}

// Alternative standalone version if you need it elsewhere
class StandaloneBottomNavWrapper extends StatefulWidget {
  final Function(int)? onTabChanged;

  const StandaloneBottomNavWrapper({
    super.key,
    this.onTabChanged,
  });

  @override
  State<StandaloneBottomNavWrapper> createState() => _StandaloneBottomNavWrapperState();
}

class _StandaloneBottomNavWrapperState extends State<StandaloneBottomNavWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (index != 3) { // Not profile tab
          setState(() {
            _selectedIndex = index;
          });
        }
        widget.onTabChanged?.call(index);
      },
    );
  }
}