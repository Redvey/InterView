import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/widgets/back_button.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final int totalQuestions;
  final VoidCallback onRestart;
  final VoidCallback onBackToTopics;

  const QuizAppBar({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.onRestart,
    required this.onBackToTopics,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button on the left
        CircleBackButton(
          pageColor: AppColors.textGreen,
          onPressed: onBackToTopics,
        ),

        // Centered text (Current/Total Questions)
        Expanded(
          child: Center(
            child: Text(
              '$currentIndex/$totalQuestions',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Popup menu on the right
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          color: Colors.grey[900],
          onSelected: (value) {
            switch (value) {
              case 'restart':
                onRestart();
                break;
              case 'topic':
                onBackToTopics();
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'restart',
              child: Text(
                'Restart Quiz',
                style: TextStyle(color: Colors.white),
              ),
            ),
            PopupMenuItem(
              value: 'topic',
              child: Text(
                'Change Topic',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    )
    ;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}