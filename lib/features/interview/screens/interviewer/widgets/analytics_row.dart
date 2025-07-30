// import 'package:flutter/material.dart';
// import 'package:interview/core/utils/extensions/responsive_extension.dart';
// import 'interview_state.dart';
//
//
// class AnalyticsRow extends StatelessWidget {
//   final InterviewState interviewState;
//
//   const AnalyticsRow({
//     super.key,
//     required this.interviewState,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildAnalyticsTile(
//             context,
//             title: 'Confidence',
//             value: '${interviewState.confidenceScore}%',
//             subtitle: interviewState.getConfidenceLabel(),
//             color: interviewState.getConfidenceColor(),
//             icon: Icons.psychology,
//           ),
//         ),
//         SizedBox(width: context.mx ),
//         Expanded(
//           child: _buildAnalyticsTile(
//             context,
//             title: 'Eye Contact',
//             value: interviewState.eyeContact,
//             subtitle: 'Tracking',
//             color: interviewState.getEyeContactColor(),
//             icon: Icons.visibility,
//           ),
//         ),
//         SizedBox(width: context.mx ),
//         Expanded(
//           child: _buildAnalyticsTile(
//             context,
//             title: 'Posture',
//             value: interviewState.posture,
//             subtitle: 'Analysis',
//             color: interviewState.getPostureColor(),
//             icon: Icons.accessibility_new,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAnalyticsTile(
//       BuildContext context, {
//         required String title,
//         required String value,
//         required String subtitle,
//         required Color color,
//         required IconData icon,
//       }) {
//     return Container(
//       padding: EdgeInsets.all(context.md ),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Colors.white.withAlpha(38), // 0.15 * 255 = 38.25 ≈ 38
//             Colors.white.withAlpha(20), // 0.08 * 255 = 20.4 ≈ 20
//           ],
//         ),
//         borderRadius: BorderRadius.circular(context.md ),
//         border: Border.all(
//           color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
//           width: context.borderWidthThin ,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
//             blurRadius: context.spaceBtwItemsH  - context.borderWidthThin ,
//             offset: Offset(0, context.xs ),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(context.paddingXS  + context.radiusXS ),
//                 decoration: BoxDecoration(
//                   color: color.withAlpha(51), // 0.2 * 255 = 51
//                   borderRadius: BorderRadius.circular(context.sm ),
//                 ),
//                 child: Icon(
//                   icon,
//                   size: context.md ,
//                   color: color,
//                 ),
//               ),
//               SizedBox(width: context.sm ),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: context.fontSizeSs ,
//                     color: Colors.white.withAlpha(179), // 0.7 * 255 = 178.5 ≈ 179
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: context.sm ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: context.fontSizeSx ,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: context.radiusXS ),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: context.fontSizeSs  - context.radiusXS,
//               color: Colors.white.withAlpha(153), // 0.6 * 255 = 153
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }