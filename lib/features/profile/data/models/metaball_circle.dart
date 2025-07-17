import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';

/// Data class representing a metaball circle
class MetaballCircle {
  final Offset position; // Circle's position on the canvas
  final double baseRadius; // Initial radius
  final double radius; // Current radius (animated)
  final double scaledRadius; // Target radius when scaled
  final Color color; // Circle color
  final Alignment scaleOrigin; // Scaling anchor point

  const MetaballCircle({
    required this.position,
    this.baseRadius = 0,
    this.radius = 0,
    this.scaledRadius = 200,
    this.scaleOrigin = Alignment.center,
    this.color = AppColors.blackLight,
  });

  /// Creates a copy of the circle with a new radius
  MetaballCircle copyWithScaledRadius(double newRadius) {
    return MetaballCircle(
      position: position,
      baseRadius: baseRadius,
      radius: newRadius,
      scaledRadius: scaledRadius,
      color: color,
      scaleOrigin: scaleOrigin,
    );
  }
}