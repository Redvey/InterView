// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:interview/core/utils/extensions/responsive_extension.dart';
//
// import '../../../core/constants/colors.dart';
// import '../../../core/constants/strings.dart';
// import '../../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
//
// class TakeMockInterview extends StatelessWidget {
//   final String title;
//   final List<String> topics;
//
//   const TakeMockInterview({
//     super.key,
//     required this.title,
//     required this.topics,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: EdgeInsets.all(context.lg),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   ResumeFormTopBar(
//                     pageColor: AppColors.blackLight,
//                     title: AppStrings.mockInterview,
//                   ),
//                   ElevatedButton(
//                     onPressed: (){
//                       context.pushNamed(
//                         'finish_interview',
//                         extra: {
//
//                         });},
//
//
//                     child: Text("data"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
