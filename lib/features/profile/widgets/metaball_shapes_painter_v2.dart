// import 'package:flutter/material.dart';
//
// import '../data/models/metaball_circle.dart';
//
// /// Alternative painter with additional color effects (Figma version)
// class MetaballShapesPainterV2 extends CustomPainter {
//   final List<MetaballCircle> circles;
//
//   MetaballShapesPainterV2({required this.circles});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (final circle in circles) {
//       final center = size.topLeft(circle.position);
//       // Calculate alignment offset for scaling origin
//       final alignmentOffset = Offset(
//         circle.scaleOrigin.x,
//         circle.scaleOrigin.y,
//       );
//       // Compute fixed point for scaling
//       final fixedPoint = center + alignmentOffset * circle.baseRadius;
//       // Adjust center to maintain fixed point during scaling
//       final adjustedCenter = fixedPoint - alignmentOffset * circle.radius;
//
//       // Draw circle with blur effect
//       canvas.drawCircle(
//         adjustedCenter,
//         circle.radius,
//         Paint()
//           ..color = circle.color
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30.0),
//       );
//     }
//
//     // Apply color dodge effect
//     canvas.drawPaint(
//       Paint()
//         ..color = const Color(0xFF808080)
//         ..blendMode = BlendMode.colorDodge,
//     );
//
//     // Apply color burn effect
//     canvas.drawPaint(
//       Paint()
//         ..color = const Color(0xff010101)
//         ..blendMode = BlendMode.colorBurn,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true; // Repaint on every frame for smooth animation
//   }
// }