import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';


import '../../../../widgets/back_button.dart';
import '../../../../widgets/profile_avatar.dart';

class ResumeFormTopBar extends StatelessWidget {
  final Color pageColor;

  const ResumeFormTopBar({
    super.key,
    required this.pageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleBackButton(pageColor: pageColor),
        Text(AppStrings.resumeBuilder, style: context.featureTitleStyle),
        const ProfileAvatar(),
      ],
    );
  }
}
