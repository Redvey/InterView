import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/utils/color_utils.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../resume/widgets/labelled_text_field.dart';

class EmailCompositionWidget extends StatelessWidget {
  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final VoidCallback onSaveDraft;
  final VoidCallback onSendEmail;

  const EmailCompositionWidget({
    super.key,
    required this.subjectController,
    required this.bodyController,
    required this.onSaveDraft,
    required this.onSendEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.md),
      decoration: BoxDecoration(
        color: AppColors.searchBorder,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(color: AppColors.backgroundBlue.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Composition",
            style: context.infoSmallHeaderStyle,
          ),
          SizedBox(height: AppSizes.defaultSpaceH(context)),

          // Subject Line
          LabeledTextFormField(
            label: "Subject Line",
            hint: "Enter email subject",
            controller: subjectController,
            containerColor: AppColors.searchBorder,
            borderColor: AppColors.backgroundWhite,
            fieldType: FieldType.text,
            isRequired: true,
            requiredMessage: 'Please enter a subject line',
            maxLength: 200,
          ),

          SizedBox(
            height: 320,
            // height: 320 * context.scaleFactor, // You can replace this with a method if reused
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Email Body",
                      style: context.detailHeaderStyle,
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: AppSizes.fontSizeSs(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.fieldLabelSpacing(context)),

                Expanded(
                  child: TextFormField(
                    controller: bodyController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: context.textFieldStyle,
                    decoration: InputDecoration(
                      hintText: "Compose your email message here...",
                      hintStyle: AppTextStyles.hintText(
                        context,
                        color: getMatchingHintColor(AppColors.searchBorder),
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM(context)),
                        borderSide: const BorderSide(color: AppColors.backgroundWhite),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM(context)),
                        borderSide: const BorderSide(color: AppColors.backgroundWhite),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM(context)),
                        borderSide: BorderSide(
                          color: AppColors.blackLight,
                          width: AppSizes.borderWidthDefault(context),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM(context)),
                        borderSide: BorderSide(
                          color: Colors.red.shade400,
                          width: AppSizes.borderWidthThin(context),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM(context)),
                        borderSide: BorderSide(
                          color: Colors.red.shade600,
                          width: AppSizes.borderWidthDefault(context),
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundWhite,
                      errorStyle: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: AppSizes.fontSizeSs(context),
                        height: 1.2,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter email content';
                      }
                      if (value.trim().length < 10) {
                        return 'Email body should be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppSizes.defaultSpaceH(context)),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSaveDraft,
                  icon: const Icon(Icons.save),
                  label: Text(
                    "Save Draft",
                    style: context.buttonWhiteTextStyle,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusMD(context)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSizes.defaultSpace(context)),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSendEmail,
                  icon: const Icon(Icons.send),
                  label: Text(
                    "Send Email",
                    style: context.buttonWhiteTextStyle,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackLight,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusMD(context)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
