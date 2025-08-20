// widgets/terms_conditions_section.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../../../core/constants/colors.dart';
import 'checked_box_tile.dart';


class TermsConditionsSection extends StatelessWidget {
  final bool agreedToTerms;
  final bool agreedToPrivacy;
  final Function(bool) onTermsChanged;
  final Function(bool) onPrivacyChanged;

  const TermsConditionsSection({
    super.key,
    required this.agreedToTerms,
    required this.agreedToPrivacy,
    required this.onTermsChanged,
    required this.onPrivacyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.backgroundYellow,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: AppColors.buttonYellow,
          width: context.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terms & Conditions',
            style: context.infoSmallHeaderStyle,
          ),
          SizedBox(height: context.paddingMD),
          CustomCheckboxTile(
            title: 'I agree to the Terms of Service',
            subtitle: 'You must agree to our terms to continue',
            value: agreedToTerms,
            onChanged: onTermsChanged,
          ),
          CustomCheckboxTile(
            title: 'I agree to the Privacy Policy',
            subtitle: 'We respect your privacy and data security',
            value: agreedToPrivacy,
            onChanged: onPrivacyChanged,
          ),
        ],
      ),
    );
  }
}