import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/strings.dart';

class ProfileSetupBottomButtons extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool isLoading;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onFinish;
  final bool Function()? validateCurrentStep;

  const ProfileSetupBottomButtons({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.isLoading,
    required this.onPrevious,
    required this.onNext,
    required this.onFinish,
    this.validateCurrentStep,
  });

  void _handleNext() {
    final isValid = validateCurrentStep?.call() ?? true;
    if (isValid) {
      onNext();
    }
  }

  void _handleFinish() {
    final isValid = validateCurrentStep?.call() ?? true;
    if (isValid) {
      onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.lg),
      child: Row(
        children: [
          if (currentStep > 0) ...[
            Expanded(child: _buildBackButton(context)),
            SizedBox(width: context.spaceBtwItems),
          ],
          Expanded(child: _buildPrimaryButton(context)),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      height: context.createButtonHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPrevious,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.blackLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusLG),
          ),
        ),
        child: Text(
          AppStrings.back,
          style: context.buttonTextStyle.copyWith(
            color: AppColors.blackLight,
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    final isLastStep = currentStep == totalSteps - 1;

    return SizedBox(
      height: context.createButtonHeight,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : (isLastStep ? _handleFinish : _handleNext),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blackLight,
          disabledBackgroundColor: AppColors.grey400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusLG),
          ),
        ),
        child: _buildButtonContent(context, isLastStep),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context, bool isLastStep) {
    if (isLoading) {
      return SizedBox(
        height: context.iconSizeSX,
        width: context.iconSizeSX,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.white),
          strokeWidth: 2,
        ),
      );
    }

    return Text(
      isLastStep ? AppStrings.finishSetup : AppStrings.next,
      style: context.buttonWhiteTextStyle,
    );
  }
}