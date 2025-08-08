import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import '../models/template_model.dart';


class TemplateChip extends StatelessWidget {
  final TemplateModel template;
  final bool isSelected;
  final VoidCallback onTap;

  const TemplateChip({
    super.key,
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 200),
        padding: EdgeInsets.all(context.paddingSM),
        constraints:  BoxConstraints(minHeight: context.buttonHeightSmall),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(context.radiusMD),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.searchBorder,
            width: context.borderWidthDefault,
          ),

        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                template.icon,
                color: isSelected ? AppColors.white : AppColors.textGrey,
                size: context.iconSizeSM,
              ),
              SizedBox(width: context.spaceBtwItems),
              Flexible(
                child: Text(
                  template.name,
                  style: isSelected
                      ? context.chipSelectedStyle
                      : context.chipUnselectedStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),


              ///If I ever decide to make it prem :D

              // if (template.isPremium)
              //   Container(
              //     margin: EdgeInsets.only(left: context.spaceBtwItems),
              //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              //     decoration: BoxDecoration(
              //       color: Colors.amber.withAlpha(204),
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //     child: Text(
              //       'PRO',
              //       style: TextStyle(
              //         fontSize: 9,
              //         color: Colors.amber[800],
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

}
