import 'package:flutter/material.dart';

class QuizCompletionDialog extends StatelessWidget {
  final String topic;
  final int done;
  final int inReview;
  final VoidCallback onBackToTopics;
  final VoidCallback onRestartQuiz;

  const QuizCompletionDialog({
    super.key,
    required this.topic,
    required this.done,
    required this.inReview,
    required this.onBackToTopics,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Quiz Complete!',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You completed $topic quiz!',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          _buildStatsRow(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onBackToTopics,
          child: const Text('Back to Topics'),
        ),
        ElevatedButton(
          onPressed: onRestartQuiz,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Restart Quiz'),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '$done',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Known',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '$inReview',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'To Review',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }
}