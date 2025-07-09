import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/themes/text_styles.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        CircleAvatar(),
        SizedBox(width: 5,),
        Text(AppStrings.hi,style: AppTextStyles.welcome,),
        SizedBox(width: 5,),
        Text(AppStrings.name,style: AppTextStyles.welcome,),

      ],
    );
  }
}