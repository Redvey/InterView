import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/strings.dart';


class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onPressed;
  final DateFormat formatter;

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
          icon:  Icon(Icons.calendar_today, size: context.iconSizeSX,color: AppColors.backgroundRedPink,),
          label: Text(
            date != null
                ? formatter.format(date!)
                : AppStrings.select,
            style:  context.buttonLightStyle,
          ),
        ),
      ],
    );
  }
}
