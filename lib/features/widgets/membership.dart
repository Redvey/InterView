import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../core/constants/colors.dart';
import 'subscription_model_bottom_sheet.dart';

class MembershipIcon extends StatelessWidget {
  const MembershipIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        color: AppColors.buttonYellow,
        size:  context.iconSize,
      ),
    );
  }
}