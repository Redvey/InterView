import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';

class FinishInterview extends StatelessWidget {


  const FinishInterview({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.specialGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(context.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  Text(AppStrings.mockInterviewCompletedTitle),
                  Text(AppStrings.mockInterviewCompletedMessage),

                  ElevatedButton(
                    onPressed: (){
                      context.pop();},


                    child: Text(AppStrings.back),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      context.pop();},


                    child: Text(AppStrings.interviewReport),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
