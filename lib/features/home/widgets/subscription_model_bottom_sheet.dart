import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class SubscriptionPlanBottomSheet extends StatefulWidget {
  const SubscriptionPlanBottomSheet({super.key});

  @override
  State<SubscriptionPlanBottomSheet> createState() =>
      _SubscriptionPlanBottomSheetState();
}

class _SubscriptionPlanBottomSheetState extends State<SubscriptionPlanBottomSheet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular( context.borderRadiusLg )),
      child: Container(
        padding:  context.screenPadding ,
        decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.purpleOverlay,
              blurRadius:  context.welcomeBlur ,
              offset:  Offset(0,  context.shadowOffsetY ),
              spreadRadius:  context.welcomeSpread ,
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular( context.borderRadiusLg )),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTag("Most Popular Choice"),
            _buildPlanTile(
              index: 0,
              title: "Annually",
              oldPrice: "₹999",
              newPrice: "₹499",
              perMonth: "₹41.5",
              save: "Save 58%",
            ),
            _buildPlanTile(
              index: 1,
              title: "Half Yearly",
              oldPrice: "₹499",
              newPrice: "₹299",
              perMonth: "₹49.5",
              save: "Save 50%",
            ),
            _buildPlanTile(
              index: 2,
              title: "Monthly",
              oldPrice: "₹299",
              newPrice: "₹99",
              note: "No long-term commitment.\nIdeal for trying out our premium features",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:  context.md , vertical:  context.spaceLess  / 2),
      margin: EdgeInsets.only(bottom:  context.spaceLess ),
      decoration: BoxDecoration(
        color: AppColors.buttonYellow,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonYellow,
            blurRadius:  context.glowBlur ,
            offset: Offset( context.shadowOffsetX2 ,  context.shadowOffsetY2 ),
            spreadRadius:  context.glowSpread ,
          ),
        ],
        borderRadius: BorderRadius.circular( context.borderRadiusMd ),
      ),
      child: Text(text, style: context.bodyBoldStyle.copyWith(color: AppColors.blackLight)),
    );
  }

  Widget _buildPlanTile({
    required int index,
    required String title,
    required String oldPrice,
    required String newPrice,
    String? perMonth,
    String? save,
    String? note,
  }) {
    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: EdgeInsets.only(top:  context.spaceLess ),
        padding:  context.screenPadding .copyWith(top:  context.md , bottom:  context.md ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.purple : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular( context.borderRadiusLg ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.purple : Colors.grey,
            ),
            SizedBox(width:  context.spaceLess ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.bodyBoldStyle.copyWith(fontSize:  context.fontSizeSx )),
                  if (perMonth != null)
                    Text(
                      "Only $perMonth per month",
                      style: context.membershipSubTitleStyle
                    ),
                  if (save != null)
                    Text(
                      "$save compared to the Monthly Plan!",
                      style: const TextStyle(color: Colors.black87),
                    ),
                  if (note != null)
                    Text(
                      note,
                      style: const TextStyle(color: Colors.black54),
                    ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  oldPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  newPrice,
                  style: context.bodyBoldStyle.copyWith(fontSize:  context.fontSizeSx ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
