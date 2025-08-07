
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';

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

  static const Map<String, String> _templateNames = {
    'informational': AppStrings.informationalTemplate,
    'jobApplication': AppStrings.jobApplicationTemplate,
    'networking': AppStrings.networkingTemplate,
    'followUp': AppStrings.followUpTemplate,
  };

  static const Map<String, IconData> _templateIcons = {
    'informational': Icons.info_outline,
    'jobApplication': Icons.work_outline,
    'networking': Icons.people_outline,
    'followUp': Icons.follow_the_signs_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.socialForm,
        borderRadius: BorderRadius.circular(context.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.selectTemplate,
                style: context.sectionTitleStyle,
              ),
              TextButton.icon(
                onPressed: onShowDrafts,
                icon: const Icon(
                  Icons.drafts_outlined,
                  color: AppColors.primary,
                ),
                label: Text(
                  AppStrings.viewDrafts,
                  style: context.buttonTextStyle.copyWith(
                    color: AppColors.primary,
                    fontSize: context.fontSizeSm,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.spaceBtwFields),

          // Template Selection Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: context.spaceBtwItems,
              mainAxisSpacing: context.spaceBtwItemsH,
            ),
            itemCount: _templateNames.length,
            itemBuilder: (context, index) {
              final templateKey = _templateNames.keys.elementAt(index);
              final templateName = _templateNames[templateKey]!;
              final templateIcon = _templateIcons[templateKey]!;
              final isSelected = selectedTemplate == templateKey;

              return _buildTemplateCard(
                context: context,
                templateKey: templateKey,
                templateName: templateName,
                templateIcon: templateIcon,
                isSelected: isSelected,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard({
    required BuildContext context,
    required String templateKey,
    required String templateName,
    required IconData templateIcon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTemplateChanged(templateKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(context.paddingMD),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.searchFill,
          borderRadius: BorderRadius.circular(context.radiusMD),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.searchBorder,
            width: context.borderWidthDefault,
          ),
          boxShadow: isSelected ? [

          ] : null,
        ),
        child: Row(
          children: [
            Icon(
              templateIcon,
              color: isSelected ? AppColors.white : AppColors.textGrey,
              size: context.iconSizeSM,
            ),
            SizedBox(width: context.mxs),
            Expanded(
              child: Text(
                templateName,
                style: context.buttonSmallStyle.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textGrey,
                  fontSize: context.fontSizeSs,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}