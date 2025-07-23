import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

class QuizStatsRow extends StatelessWidget {
  final int inReview;
  final int done;

  const QuizStatsRow({
    super.key,
    required this.inReview,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_emotions,color: AppColors.backgroundYellow,size: context.iconSize,),
            const SizedBox(width: 8),
            Text(
              '$inReview In Review',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.check,size: context.iconSize,color: AppColors.textGreen,),
            const SizedBox(width: 8),
            Text(
              '$done Done',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}