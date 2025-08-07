import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';

import '../../resume/widgets/labelled_text_field.dart';

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

class _RecipientDetailsWidgetState extends State<RecipientDetailsWidget>
    with TickerProviderStateMixin {
  bool _isPersonalizing = false;
  bool _isPersonalized = false;
  late AnimationController _animationController;
  late AnimationController _successController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _successController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _successController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _successController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _successController.dispose();
    super.dispose();
  }

  bool get _areFieldsFilled {
    return widget.recipientController.text.trim().isNotEmpty &&
        widget.recipientEmailController.text.trim().isNotEmpty &&
        widget.companyController.text.trim().isNotEmpty &&
        widget.positionController.text.trim().isNotEmpty;
  }

  Future<void> _handlePersonalize() async {
    if (!_areFieldsFilled) {
      // Show a snackbar or toast indicating fields need to be filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all recipient details first'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isPersonalizing = true;
      _isPersonalized = false;
    });

    _animationController.repeat();

    // Call the original callback
    widget.onPersonalize();

    // Simulate personalization process (you can adjust this timing)
    await Future.delayed(const Duration(milliseconds: 2000));

    _animationController.stop();

    setState(() {
      _isPersonalizing = false;
      _isPersonalized = true;
    });

    // Start success animation
    _successController.forward();

    // Reset success state after a delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          _isPersonalized = false;
        });
        _successController.reset();
      }
    });
  }

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
          Text(
            AppStrings.recipientDetails,
            style: context.sectionTitleStyle,
          ),
          SizedBox(height: context.spaceBtwFields),

          LabeledTextFormField(
            label: "Recipient Email",
            hint: "Enter recipient's email address",
            controller: widget.recipientEmailController,
            containerColor: AppColors.searchBorder,
            borderColor: AppColors.backgroundWhite,
            fieldType: FieldType.email,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: context.spaceBtwInputFields),

          // Row for side-by-side fields
          Row(
            children: [
              Expanded(
                child: LabeledTextFormField(
                  label: "Recipient Name",
                  hint: "Enter recipient's name",
                  controller: widget.recipientController,
                  containerColor: AppColors.searchBorder,
                  borderColor: AppColors.backgroundWhite,
                  fieldType: FieldType.name,
                ),
              ),
              SizedBox(width: context.spaceBtwInputFields),
              Expanded(
                child: LabeledTextFormField(
                  label: "Company",
                  hint: "Enter company name",
                  controller: widget.companyController,
                  containerColor: AppColors.searchBorder,
                  borderColor: AppColors.backgroundWhite,
                  fieldType: FieldType.company,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spaceBtwInputFields),

          LabeledTextFormField(
            label: "Position/Field of Interest",
            hint: "Enter position or field of interest",
            controller: widget.positionController,
            containerColor: AppColors.searchBorder,
            borderColor: AppColors.backgroundWhite,
            fieldType: FieldType.jobTitle,
            isLastField: true,
          ),
          SizedBox(height: context.spaceBtwInputFields),

          AnimatedBuilder(
            animation: Listenable.merge([_animationController, _successController]),
            builder: (context, child) {
              return Transform.scale(
                scale: _isPersonalized ? _scaleAnimation.value : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: _isPersonalized
                        ? Colors.green.withOpacity(0.8)
                        : _areFieldsFilled
                        ? AppColors.blackLight
                        : AppColors.blackLight.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(context.radiusMD),
                    ),
                  ),
                  child: TextButton.icon(
                    onPressed: _isPersonalizing ? null : _handlePersonalize,
                    icon: _isPersonalizing
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.purpleLight,
                        ),
                      ),
                    )
                        : _isPersonalized
                        ? FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    )
                        : Icon(
                      Icons.auto_fix_high,
                      color: _areFieldsFilled
                          ? AppColors.purpleLight
                          : AppColors.purpleLight.withOpacity(0.5),
                    ),
                    label: Text(
                      _isPersonalizing
                          ? "Personalizing..."
                          : _isPersonalized
                          ? "Email Personalized!"
                          : AppStrings.personalizeEmail,
                      style: context.buttonTextStyle.copyWith(
                        color: _areFieldsFilled
                            ? AppColors.white
                            : AppColors.white.withOpacity(0.5),
                        fontSize: context.fontSizeSten,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}