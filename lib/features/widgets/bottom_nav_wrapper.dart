import 'package:flutter/cupertino.dart';

import '../home/widgets/custom_bottom_nav.dart';

class MyBottomNavWrapper extends StatefulWidget {
  const MyBottomNavWrapper({super.key});

  @override
  State<MyBottomNavWrapper> createState() => _MyBottomNavWrapperState();
}

class _MyBottomNavWrapperState extends State<MyBottomNavWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Future: Add navigation logic here
      },
    );
  }
}
