import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/strings.dart';


class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onPressed;
  final DateFormat formatter; // Pass formatter if needed, or create internally

  const DatePickerField({
    super.key,
    required this.label,
    this.date,
    required this.onPressed,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        TextButton.icon(

          onPressed: onPressed,
          icon: const Icon(Icons.calendar_today, size: 16,color: AppColors.backgroundRedPink,),
          label: Text(
            date != null
                ? formatter.format(date!)
                : AppStrings.select,
            style: AppTextStyles.buttonLight,// Assuming AppStrings.select exists
          ),
        ),
      ],
    );
  }
}
