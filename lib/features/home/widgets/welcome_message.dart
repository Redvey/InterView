import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/profile/profile_avatar.dart';

import '../../widgets/membership.dart';


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
        MembershipIcon(),
      ],
    );
  }
}



