import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/strings.dart';

class BasicDetailsDobField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const BasicDetailsDobField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
      selectedDate ?? DateTime.now().subtract(const Duration(days: 6570)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blackLight,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: AppStrings.dobLabel,
            hintText: AppStrings.dobHint,
            prefixIcon: Icon(Icons.calendar_today_outlined,
                size: context.iconSizeMD),
            suffixIcon: Icon(Icons.keyboard_arrow_down, size: context.iconSizeMD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
          ),
          controller: TextEditingController(
            text: selectedDate != null ? _formatDate(selectedDate!) : '',
          ),
          validator: (_) =>
          selectedDate == null ? AppStrings.dobEmptyError : null,
        ),
      ),
    );
  }
}
