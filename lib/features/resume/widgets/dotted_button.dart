import 'package:flutter/material.dart';

import '../../../app/themes/text_styles.dart';

class DottedBorderButton extends StatelessWidget {
  final String detail;
  const DottedBorderButton({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Text(
        '+$detail',
        style: AppTextStyles.buttonLight,
      ),
    );
  }
}