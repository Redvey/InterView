import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/resume/screens/experience_form/experience_entry_model.dart';
import 'package:interview/features/resume/screens/experience_form/widgets/toggle_field.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/color_utils.dart';// Update with correct path
import '../../../widgets/labelled_text_field.dart';
import 'date_picker.dart';

class ExperienceCard extends StatefulWidget {
  final ExperienceEntry experience;
  final VoidCallback onRemove;
  final bool isLast;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onRemove,
    this.isLast = false,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  final DateFormat formatter = DateFormat.yMMM();

  // Focus nodes for proper navigation
  late final FocusNode _jobTitleFocus;
  late final FocusNode _companyFocus;
  late final FocusNode _descriptionFocus;

  @override
  void initState() {
    super.initState();
    _jobTitleFocus = FocusNode();
    _companyFocus = FocusNode();
    _descriptionFocus = FocusNode();
  }

  @override
  void dispose() {
    _jobTitleFocus.dispose();
    _companyFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  Future<void> _selectDate({required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.backgroundRed,
              onPrimary: AppColors.backgroundWhite,
              onSurface: AppColors.backgroundPink,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.backgroundRedPink,
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: AppColors.blackLight),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          widget.experience.fromDate = picked;
        } else {
          widget.experience.toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lighterJobColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          LabeledTextFormField(
            label: "Job Title",
            hint: AppStrings.jobTitle,
            controller: exp.jobTitleController,
            containerColor: lighterJobColor,
            focusNode: _jobTitleFocus,
            nextFocus: _companyFocus,
            fieldType: FieldType.jobTitle,
            isRequired: true,
          ),
          const SizedBox(height: 8),

          LabeledTextFormField(
            label: "Company",
            hint: AppStrings.company,
            controller: exp.companyController,
            containerColor: lighterJobColor,
            focusNode: _companyFocus,
            nextFocus: _descriptionFocus,
            fieldType: FieldType.company,
            isRequired: true,
          ),
          const SizedBox(height: 8),

          LabeledTextFormField(
            label: "Description",
            hint: AppStrings.jobDescription,
            controller: exp.descriptionController,
            maxLines: 4,
            containerColor: lighterJobColor,
            focusNode: _descriptionFocus,
            fieldType: FieldType.description,
            isRequired: true,
            isLastField: widget.isLast,
          ),
          const SizedBox(height: 12),

          DatePickerField(
            label: AppStrings.from,
            date: exp.fromDate,
            onPressed: () => _selectDate(isFrom: true),
            formatter: formatter,
          ),

          ToggleField(
            label: AppStrings.stillWorkHere,
            value: exp.isCurrent,
            onChanged: (value) {
              setState(() {
                exp.isCurrent = value;
                if (value) exp.toDate = null;
              });
            },
          ),

          if (!exp.isCurrent)
            DatePickerField(
              label: AppStrings.to,
              date: exp.toDate,
              onPressed: () => _selectDate(isFrom: false),
              formatter: formatter,
            ),
          const SizedBox(height: 12),

          TextButton.icon(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const Text(
              AppStrings.removeExperience,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}



