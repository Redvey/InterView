import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';



class InterviewReportsScreen extends StatelessWidget {
  const InterviewReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
    );
  }
}
class FlashCardsScreen extends StatelessWidget {
  const FlashCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flash Cards')),
      body: const Center(
        child: Text('Flash Cards Content'),
      ),
    );
  }
}
