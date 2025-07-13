import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/color_utils.dart'; // for getMatchingHintColor

class CircleBackButton extends StatelessWidget {
  final Color pageColor;
  final VoidCallback? onPressed;

  const CircleBackButton({
    super.key,
    required this.pageColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, size: 16, color: AppColors.backgroundWhite),
        style: IconButton.styleFrom(
          backgroundColor: getMatchingHintColor(pageColor),
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          elevation: 1,
        ),
        onPressed: onPressed ?? () => context.pop(),
      ),
    );
  }
}
