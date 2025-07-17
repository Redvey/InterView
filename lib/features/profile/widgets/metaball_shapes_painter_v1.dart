import 'package:flutter/material.dart';

import '../data/models/metaball_circle.dart';

/// Custom painter for drawing metaball circles
class MetaballShapesPainterV1 extends CustomPainter {
  final List<MetaballCircle> circles;

  MetaballShapesPainterV1({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final circle in circles) {
      final center = size.topLeft(circle.position);
      // Calculate alignment offset for scaling origin
      final alignmentOffset = Offset(
        circle.scaleOrigin.x,
        circle.scaleOrigin.y,
      );
      // Compute fixed point for scaling
      final fixedPoint = center + alignmentOffset * circle.baseRadius;
      // Adjust center to maintain fixed point during scaling
      final adjustedCenter = fixedPoint - alignmentOffset * circle.radius;
      // final fixedPoint = center + alignmentOffset * size.shortestSide;
      // final adjustedCenter = fixedPoint - alignmentOffset * circle.radius;

      // Draw circle with blur effect
      canvas.drawCircle(
        adjustedCenter,
        circle.radius,
        Paint()
          ..color = circle.color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is MetaballShapesPainterV1) {
      return oldDelegate.circles != circles;
    }
    return true; // Repaint on every frame for smooth animation
  }
}
