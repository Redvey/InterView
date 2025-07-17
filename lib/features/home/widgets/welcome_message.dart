import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
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
            const ProfileAvatar(),
            SizedBox(width:  context.headSubhead ),
            Text(AppStrings.hi, style: context.welcomeStyle ),
            SizedBox(width:  context.headSubhead ),
            Text(AppStrings.name, style: context.welcomeStyle ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular( context.sheetRadius)),
              ),
              builder: (_) => const SubscriptionPlanBottomSheet(),
            );
          },
          child: Icon(
            Icons.workspace_premium_sharp,
            color: AppColors.buttonTextGray,
            size:  context.iconSize,
          ),
        ),
      ],
    );
  }
}

