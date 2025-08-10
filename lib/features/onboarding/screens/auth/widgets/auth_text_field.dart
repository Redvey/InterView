import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';



class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: _buildInputDecoration(context),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return InputDecoration(
      labelText: labelText,
      labelStyle: context.hintTextStyle(color: AppColors.blackLight),
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: AppColors.blackLight),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide:  BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide:  BorderSide(color: AppColors.blackLight, width: context.borderWidthThin),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide:  BorderSide(color: AppColors.red, width:context.borderWidthThin),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide:  BorderSide(color: AppColors.red, width: context.borderWidthThin),
      ),
      contentPadding:  EdgeInsets.all(
        context.md
      ),
    );
  }
}
