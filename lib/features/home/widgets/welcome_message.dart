import 'package:flutter/material.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/features/widgets/profile_avatar.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        ProfileAvatar(),
        SizedBox(width: AppSizes.headSubhead,),
        Text(AppStrings.hi,style: AppTextStyles.welcome,),
        SizedBox(width: AppSizes.headSubhead,),
        Text(AppStrings.name,style: AppTextStyles.welcome,),

      ],
    );
  }
}