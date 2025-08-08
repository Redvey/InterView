import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/cold_email/widgets/recipient_details/widget/personalize_button.dart';
import 'package:interview/features/cold_email/widgets/recipient_details/widget/recipient_form_fields.dart';


class RecipientDetailsWidget extends StatefulWidget {
  final TextEditingController recipientController;
  final TextEditingController recipientEmailController;
  final TextEditingController companyController;
  final TextEditingController positionController;
  final VoidCallback onPersonalize;

  const RecipientDetailsWidget({
    super.key,
    required this.recipientController,
    required this.recipientEmailController,
    required this.companyController,
    required this.positionController,
    required this.onPersonalize,
  });

  @override
  State<RecipientDetailsWidget> createState() => _RecipientDetailsWidgetState();
}

class _RecipientDetailsWidgetState extends State<RecipientDetailsWidget> {
  bool _isPersonalizing = false;
  bool _isPersonalized = false;

  bool get _areFieldsFilled {
    return widget.recipientController.text.trim().isNotEmpty &&
        widget.recipientEmailController.text.trim().isNotEmpty &&
        widget.companyController.text.trim().isNotEmpty &&
        widget.positionController.text.trim().isNotEmpty;
  }

  Future<void> _handlePersonalize() async {
    if (!_areFieldsFilled) {
      _showValidationError();
      return;
    }

    setState(() {
      _isPersonalizing = true;
      _isPersonalized = false;
    });

    widget.onPersonalize();
    await Future.delayed(const Duration(milliseconds: 2000));

    setState(() {
      _isPersonalizing = false;
      _isPersonalized = true;
    });

    // Reset success state after delay
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() => _isPersonalized = false);
      }
    });
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.fillAllRecipientDetails,style: context.snackBarTextStyle),
        backgroundColor: AppColors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.socialForm,
          border: Border.all(color: AppColors.blue800),
        borderRadius: BorderRadius.circular(context.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.recipientDetails,
            style: context.sectionTitleStyle,
          ),
          SizedBox(height: context.spaceBtwFields),

          RecipientFormFields(
            recipientController: widget.recipientController,
            recipientEmailController: widget.recipientEmailController,
            companyController: widget.companyController,
            positionController: widget.positionController,
          ),

          SizedBox(height: context.spaceBtwInputFields),

          PersonalizeButton(
            isPersonalizing: _isPersonalizing,
            isPersonalized: _isPersonalized,
            areFieldsFilled: _areFieldsFilled,
            onPressed: _handlePersonalize,
          ),
        ],
      ),
    );
  }
}
