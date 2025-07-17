import 'package:flutter/material.dart';
import '../data/models/metaball_circle.dart';

/// Configuration class for metaball circles
class MetaballConfig {
  /// Creates the default configuration of metaball circles
  static List<MetaballCircle> createDefaultCircles(Size screenSize, double topPadding) {
    return [
      // Circle starting from the menu button (top-left)
      MetaballCircle(
        position: Offset(16, topPadding),
        scaleOrigin: Alignment.topLeft,
        scaledRadius: 300, // Target radius when expanded
      ),
      // Circle from top-right outside the screen
      MetaballCircle(
        position: Offset(screenSize.width, -50),
        scaleOrigin: Alignment.center,
        scaledRadius: 250,
      ),
      // Circle from middle-right of the screen
      MetaballCircle(
        position: Offset(
          screenSize.width + 100,
          (screenSize.height / 2) + 100,
        ),
        scaleOrigin: Alignment.center,
        scaledRadius: 300,
      ),
      // Circle from top-left outside the screen
      MetaballCircle(
        position: Offset(-10, 50),
        scaleOrigin: Alignment.centerLeft,
        scaledRadius: 200,
      ),
      // Circle from middle-left of the screen
      MetaballCircle(
        position: Offset(-100, (screenSize.height / 2) + 100),
        scaleOrigin: Alignment.center,
        scaledRadius: 500,
      ),
      // Circle from bottom-left of the screen
      MetaballCircle(
        position: Offset(-30, screenSize.height + 50),
        scaledRadius: 500,
        scaleOrigin: Alignment.bottomLeft,
      ),
      // Circle from bottom-left outside the screen
      MetaballCircle(
        position: Offset(-10, screenSize.height + 10),
        scaledRadius: 500,
        scaleOrigin: Alignment.center,
      ),
    ];
  }

  /// Animation duration constants
  static const Duration animationDuration = Duration(milliseconds: 1000);
  static const Duration closeButtonAnimationDuration = Duration(milliseconds: 850);

  /// Color matrix for metaball effect
  static const List<double> metaballColorMatrix = <double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 60, -6000,
  ];
}