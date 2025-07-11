import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/resume/widgets/dotted_button.dart';



class UnderDev extends StatelessWidget {
  const UnderDev({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("COMING SOON"),
            SizedBox(height: 50,),
            GestureDetector(
                onTap: () => Navigator.pop(context),

                child: DottedBorderButton(detail: 'GO BACK',))
          ],
        ),

    );
  }
}
