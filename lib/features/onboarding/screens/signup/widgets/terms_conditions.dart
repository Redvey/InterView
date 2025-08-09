import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

class TermsAndConditions extends StatelessWidget {
  final bool agreeToTerms;
  final ValueChanged<bool?> onChanged;

  const TermsAndConditions({
    super.key,
    required this.agreeToTerms,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: agreeToTerms,
          onChanged: onChanged,
          activeColor: AppColors.blue600,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusXS)),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: context.paddingMD),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: context.fontSizeSm,
                  color: AppColors.textGrey,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: const TextStyle(
                      color: AppColors.blue600,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // TODO: Navigate to Terms of Service page
                    },
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      color: AppColors.blue600,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // TODO: Navigate to Privacy Policy page
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}