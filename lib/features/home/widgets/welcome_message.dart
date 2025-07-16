import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/features/home/widgets/subscription_model_bottom_sheet.dart';
import 'package:interview/features/widgets/profile_avatar.dart';


class WelcomeMessage extends StatefulWidget {
  const WelcomeMessage({super.key});

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}


class _WelcomeMessageState extends State<WelcomeMessage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ProfileAvatar(),
            SizedBox(width: AppSizes.headSubhead),
            Text(AppStrings.hi, style: AppTextStyles.welcome),
            SizedBox(width: AppSizes.headSubhead),
            Text(AppStrings.name, style: AppTextStyles.welcome),
          ],
        ),
        GestureDetector(
          onTap:  (){
            //bottom sheet
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => const SubscriptionPlanBottomSheet(),
            );

          },
          child: Icon(
            Icons.workspace_premium_sharp,
            color: AppColors.buttonTextGray,
            size: AppSizes.iconSize,


          ),
        ),
      ],
    );
  }
}
