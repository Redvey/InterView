import 'package:flutter/material.dart';

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
            const Text('😊', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              '$inReview In Review',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            const Text('✅', style: TextStyle(fontSize: 20)),
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