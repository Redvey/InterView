// widgets/template_selection_widget.dart
import 'package:flutter/material.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/utils/color_utils.dart';
import '../../../core/constants/colors.dart';

class TemplateSelectionWidget extends StatelessWidget {
  final String selectedTemplate;
  final Function(String) onTemplateChanged;
  final VoidCallback onShowDrafts;

  const TemplateSelectionWidget({
    super.key,
    required this.selectedTemplate,
    required this.onTemplateChanged,
    required this.onShowDrafts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.searchBorder,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.backgroundBlue.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Email Template",
                style: context.infoSmallHeaderStyle
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: onShowDrafts,
                icon: const Icon(Icons.drafts, size: 16),
                label:  Text('Drafts',style: TextStyle(fontFamily: AppFonts.poppins),),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.blackLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Template Selection using consistent styling
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TEMPLATE TYPE",
                style: context.detailHeaderStyle,
              ),
              SizedBox(height: context.fieldLabelSpacing),

              DropdownButtonFormField<String>(
                value: selectedTemplate,
                style: context.textFieldStyle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radiusSM),
                    borderSide: BorderSide(color: AppColors.backgroundWhite),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radiusSM),
                    borderSide: BorderSide(color: AppColors.backgroundWhite),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radiusSM),
                    borderSide: BorderSide(
                      color: AppColors.blackLight,
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.backgroundWhite,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                items:  [
                  DropdownMenuItem(
                    value: 'informational',
                    child: Text('Informational Interview',style: context.hintTextStyle(color: getMatchingHintColor(AppColors.searchBorder)),),
                  ),
                  DropdownMenuItem(
                    value: 'job_inquiry',
                    child: Text('Job Inquiry',style: context.hintTextStyle(color: getMatchingHintColor(AppColors.searchBorder))),
                  ),
                  DropdownMenuItem(
                    value: 'networking',
                    child: Text('Networking',style: context.hintTextStyle(color: getMatchingHintColor(AppColors.searchBorder))),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onTemplateChanged(value);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a template type';
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}