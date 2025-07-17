import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';


import '../../../../widgets/back_button.dart';
import '../../../../widgets/membership.dart';

class ResumeFormTopBar extends StatelessWidget {
  final Color pageColor;
  final String title;

  const ResumeFormTopBar({
    super.key,
    required this.pageColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleBackButton(pageColor: pageColor),
        Text(title, style: context.featureTitleStyle),
        const MembershipIcon(),
      ],
    );
  }
}
