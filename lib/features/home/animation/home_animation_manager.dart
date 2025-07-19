import 'package:flutter/animation.dart';

class HomeAnimationManager {
  final AnimationController controller;
  late List<Animation<double>> fadeAnimations;
  late List<Animation<Offset>> slideAnimations;

  HomeAnimationManager(this.controller) {
    _initializeAnimations();
  }

  void _initializeAnimations() {
    fadeAnimations = List.generate(8, (index) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          index * 0.1, // Start each animation 100ms apart
          0.8 + (index * 0.02), // End times slightly staggered
          curve: Curves.easeOutCubic,
        ),
      ));
    });

    slideAnimations = List.generate(8, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.3), // Start 30% down
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          index * 0.1,
          0.8 + (index * 0.02),
          curve: Curves.easeOutCubic,
        ),
      ));
    });
  }
}