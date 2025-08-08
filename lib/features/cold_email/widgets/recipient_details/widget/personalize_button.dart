import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'animated_loading.dart';


class PersonalizeButton extends StatefulWidget {
  final bool isPersonalizing;
  final bool isPersonalized;
  final bool areFieldsFilled;
  final VoidCallback onPressed;

  const PersonalizeButton({
    super.key,
    required this.isPersonalizing,
    required this.isPersonalized,
    required this.areFieldsFilled,
    required this.onPressed,
  });

  @override
  State<PersonalizeButton> createState() => _PersonalizeButtonState();
}

class _PersonalizeButtonState extends State<PersonalizeButton>
    with TickerProviderStateMixin {
  late AnimationController _successController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _successController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _successController, curve: Curves.easeIn),
    );
  }

  @override
  void didUpdateWidget(PersonalizeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPersonalized && !oldWidget.isPersonalized) {
      _successController.forward();
    } else if (!widget.isPersonalized && oldWidget.isPersonalized) {
      _successController.reset();
    }
  }

  @override
  void dispose() {
    _successController.dispose();
    super.dispose();
  }

  Widget _buildLoadingIndicator() {
    return const AnimatedLoadingText();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _successController,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isPersonalized ? _scaleAnimation.value : 1.0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.isPersonalized
                  ? AppColors.backgroundGreen
                  : widget.areFieldsFilled
                  ? AppColors.blackLight
                  : AppColors.greyDark,
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
            child: TextButton.icon(
              onPressed: widget.isPersonalizing ? null : widget.onPressed,
              icon: widget.isPersonalizing
                  ? _buildLoadingIndicator()
                  : widget.isPersonalized
                  ? FadeTransition(
                opacity: _fadeAnimation,
                child:  Icon(
                  Icons.check_circle,
                  size: context.iconSizeSM,
                  color: AppColors.white,
                ),
              )
                  : Icon(
                Icons.auto_fix_high,
                size: context.iconSizeSm,
                color: AppColors.purpleLight,
              ),
              label: Text(
                widget.isPersonalizing
                    ? AppStrings.craftEmail
                    : widget.isPersonalized
                    ? AppStrings.emailPersonalized
                    : AppStrings.personalizeEmail,
                style: context.buttonTextStyle.copyWith(
                  color: AppColors.purpleLight,
                  fontSize: context.fontSizeSs,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}