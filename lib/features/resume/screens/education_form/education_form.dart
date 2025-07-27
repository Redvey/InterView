import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/utils/color_utils.dart';
import 'package:interview/features/resume/widgets/dotted_button.dart';
import 'package:interview/features/resume/widgets/labelled_text_field.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({super.key});

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final List<int> _entryIds = [];

  @override
  void initState() {
    super.initState();
    _addEducationEntry();
  }

  void _addEducationEntry() {
    setState(() {
      _entryIds.add(DateTime.now().millisecondsSinceEpoch);
    });
  }

  void _removeEducationEntry(int index) {
    setState(() {
      _entryIds.removeAt(index);
    });
  }

  Widget _buildEducationEntry(int index, Color containerColor) {
    return Container(
      margin:  EdgeInsets.only(bottom: context.lgV),
      padding:  EdgeInsets.all(context.mxs),
      decoration: BoxDecoration(
        color: AppColors.educationForm,
        borderRadius: BorderRadius.circular(context.borderRadiusLx),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.educationEntryTitle,
                style: AppTextStyles.buttonLight(context)
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _removeEducationEntry(index),
              ),
            ],
          ),
          SizedBox(height: context.mxs),
          LabeledTextFormField(
            label: AppStrings.institutionNameLabel,
            hint: AppStrings.institutionNameHint,
            containerColor: containerColor,
          ),
          SizedBox(height: context.spaceBtwItemsH),
          LabeledTextFormField(
            label: AppStrings.courseNameLabel,
            hint: AppStrings.courseNameHint,
            containerColor: containerColor,
          ),
          SizedBox(height: context.spaceBtwItemsH),
          LabeledTextFormField(
            label: AppStrings.scoreLabel,
            hint: AppStrings.scoreHint,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            containerColor: containerColor,
          ),
          SizedBox(height: context.spaceBtwItemsH),
          LabeledTextFormField(
            label: AppStrings.passingYearLabel,
            hint: AppStrings.passingYearHint,
            keyboardType: TextInputType.number,
            containerColor: containerColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color containerColor = darkerEducationColor;

    return Padding(
      padding: EdgeInsets.all(context.paddingMD),
      child: Container(
        padding: EdgeInsets.all(context.paddingMD),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(context.borderRadiusLx),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.educationSectionTitle, style: context.infoHeaderStyle), 
              SizedBox(height: context.defaultSpaceH),
              ..._entryIds.asMap().entries.map(
                    (entry) => _buildEducationEntry(entry.key, containerColor),
              ),
              SizedBox(height: context.defaultSpaceH),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _addEducationEntry,
                  child: DottedBorderButton(
                    detail: AppStrings.addEducationButtonLabel, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
