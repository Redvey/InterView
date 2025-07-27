import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview/features/resume/widgets/input_decoration.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/color_utils.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

import '../../../core/utils/validators.dart';

enum FieldType {
  text,
  name,
  email,
  phone,
  url,
  number,
  currency,
  multiline,
  jobTitle,
  company,
  description,
  experience,
  password,
  socialLink,
  projectTitle,
  location,
}

class LabeledTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final Color containerColor;
  final Color? borderColor;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final String? Function(String?)? validator;
  final bool removable;
  final VoidCallback? onRemove;
  final FieldType fieldType;
  final bool isRequired;
  final bool isLastField;
  final List<TextInputFormatter>? customFormatters;
  final int? maxLength;
  final bool obscureText;
  final String? requiredMessage;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final bool showCounter;
  final bool autocorrect;

  const LabeledTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    required this.containerColor,
    this.borderColor = AppColors.backgroundWhite,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.removable = false,
    this.onRemove,
    this.fieldType = FieldType.text,
    this.isRequired = false,
    this.isLastField = false,
    this.customFormatters,
    this.maxLength,
    this.obscureText = false,
    this.requiredMessage,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.initialValue,
    this.showCounter = false,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color hintTextColor = getMatchingHintColor(containerColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label and optional remove button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  label.toUpperCase(),
                  style: context.detailHeaderStyle.copyWith(
                    color: enabled
                        ? context.detailHeaderStyle.color
                        : context.detailHeaderStyle.color?.withAlpha(153),
                  ),
                ),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
              ],
            ),
            if (removable && onRemove != null)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red, size: 20),
                onPressed: enabled ? onRemove : null,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),

        SizedBox(height: context.fieldLabelSpacing),

        // TextFormField with enhanced formatting and validation
        TextFormField(
          style: context.textFieldStyle.copyWith(
            color: enabled
                ? context.textFieldStyle.color
                : context.textFieldStyle.color?.withAlpha(153),
          ),
          controller: controller,
          initialValue: initialValue,
          maxLines: _getMaxLines(),
          maxLength: maxLength ?? _getMaxLength(),
          keyboardType: _getKeyboardType(),
          focusNode: focusNode,
          validator: _buildValidator(),
          obscureText: obscureText,
          autocorrect:
              autocorrect &&
              fieldType != FieldType.email &&
              fieldType != FieldType.url,
          textCapitalization: _getTextCapitalization(),
          textInputAction: _getTextInputAction(),
          inputFormatters: _getInputFormatters(),
          enabled: enabled,
          readOnly: readOnly,
          onFieldSubmitted: (value) {
            if (onFieldSubmitted != null) {
              onFieldSubmitted!(value);
            } else if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          },
          onChanged: onChanged,
          decoration:
              whiteInputDecoration(
                context,
                hint,
                hintTextColor,
                borderColor ?? AppColors.backgroundWhite,
              ).copyWith(
                counterText: showCounter ? null : '',
                enabled: enabled,
                filled: true,
                fillColor: enabled
                    ? AppColors.backgroundWhite
                    : containerColor.withAlpha(127),
                // Enhanced error styling
                errorStyle: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 12,
                  height: 1.2,
                ),
                errorMaxLines: 2,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusSM),
                  borderSide: BorderSide(
                    color: Colors.red.shade400,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusSM),
                  borderSide: BorderSide(
                    color: Colors.red.shade600,
                    width: 2.0,
                  ),
                ),
                // Enhanced focus styling
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusSM),
                  borderSide: BorderSide(
                    color: AppColors.blackLight,
                    width: 2.0,
                  ),
                ),
                // Disabled state styling
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusSM),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
              ),
        ),

        SizedBox(height: context.spaceBtwFields),
      ],
    );
  }

  int _getMaxLines() {
    if (maxLines > 1) return maxLines;

    switch (fieldType) {
      case FieldType.multiline:
      case FieldType.description:
        return maxLines > 1 ? maxLines : 4;
      default:
        return 1;
    }
  }

  TextInputType _getKeyboardType() {
    if (keyboardType != null) return keyboardType!;

    switch (fieldType) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.phone:
        return TextInputType.phone;
      case FieldType.number:
      case FieldType.experience:
        return TextInputType.number;
      case FieldType.currency:
        return const TextInputType.numberWithOptions(decimal: true);
      case FieldType.url:
      case FieldType.socialLink:
        return TextInputType.url;
      case FieldType.multiline:
      case FieldType.description:
        return TextInputType.multiline;
      case FieldType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  TextCapitalization _getTextCapitalization() {
    switch (fieldType) {
      case FieldType.name:
      case FieldType.jobTitle:
      case FieldType.company:
      case FieldType.projectTitle:
      case FieldType.location:
        return TextCapitalization.words;
      case FieldType.description:
      case FieldType.multiline:
        return TextCapitalization.sentences;
      case FieldType.email:
      case FieldType.url:
      case FieldType.socialLink:
      case FieldType.password:
        return TextCapitalization.none;
      default:
        return TextCapitalization.sentences;
    }
  }

  TextInputAction _getTextInputAction() {
    if (textInputAction != null) return textInputAction!;
    if (isLastField) return TextInputAction.done;
    if (nextFocus != null) return TextInputAction.next;
    if (fieldType == FieldType.multiline ||
        fieldType == FieldType.description) {
      return TextInputAction.newline;
    }
    return TextInputAction.next;
  }

  int? _getMaxLength() {
    switch (fieldType) {
      case FieldType.phone:
        return 14; // XXX-XXX-XXXX format
      case FieldType.name:
        return 50;
      case FieldType.jobTitle:
      case FieldType.company:
      case FieldType.projectTitle:
        return 100;
      case FieldType.email:
        return 254; // RFC standard
      case FieldType.experience:
        return 2; // Max 99 years
      case FieldType.location:
        return 100;
      default:
        return null;
    }
  }

  List<TextInputFormatter> _getInputFormatters() {
    List<TextInputFormatter> formatters = [];

    // Add custom formatters first if provided
    if (customFormatters != null) {
      formatters.addAll(customFormatters!);
      return formatters; // Return early if custom formatters provided
    }

    switch (fieldType) {
      case FieldType.phone:
        formatters.addAll([
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
          FormFormatters.phoneFormatter(),
        ]);
        break;

      case FieldType.name:
      case FieldType.jobTitle:
      case FieldType.company:
      case FieldType.projectTitle:
        formatters.addAll([
          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\s\-\.\(\)&/]")),
          FormFormatters.capitalizeWordsFormatter(),
        ]);
        break;

      case FieldType.location:
        formatters.addAll([
          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s,\-\']")),
          FormFormatters.currencyFormatter(),
        ]);
        break;

      case FieldType.email:
        formatters.addAll([
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // No spaces
          FormFormatters.lowercaseFormatter(),
        ]);
        break;

      case FieldType.number:
      case FieldType.experience:
        formatters.addAll([FilteringTextInputFormatter.digitsOnly]);
        break;

      case FieldType.currency:
        formatters.addAll([
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          FormFormatters.currencyFormatter(),
        ]);
        break;

      case FieldType.url:
      case FieldType.socialLink:
        formatters.addAll([
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // No spaces
          FormFormatters.urlFormatter(),
        ]);
        break;

      case FieldType.description:
      case FieldType.multiline:
        // Allow all characters for descriptions
        break;

      case FieldType.password:
        formatters.addAll([
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // No spaces
        ]);
        break;

      default:
        break;
    }

    return formatters;
  }

  String? Function(String?)? _buildValidator() {
    if (validator != null) return validator;

    return (String? value) {
      // Check if field is required
      if (isRequired && (value == null || value.trim().isEmpty)) {
        return requiredMessage ?? '$label is required';
      }

      // Skip validation if field is empty and not required
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      final trimmedValue = value.trim();

      // Field-specific validation
      switch (fieldType) {
        case FieldType.email:
          return CommonValidators.email(trimmedValue);

        case FieldType.phone:
          return CommonValidators.phone(trimmedValue);

        case FieldType.url:
        case FieldType.socialLink:
          return CommonValidators.url(trimmedValue);

        case FieldType.name:
        case FieldType.jobTitle:
        case FieldType.company:
        case FieldType.projectTitle:
          if (trimmedValue.length < 2) {
            return '$label must be at least 2 characters';
          }
          break;

        case FieldType.experience:
          final numValue = int.tryParse(trimmedValue);
          if (numValue == null || numValue < 0 || numValue > 99) {
            return 'Enter experience between 0-99 years';
          }
          break;

        case FieldType.currency:
          if (!FormValidationUtils.isValidCurrency(trimmedValue)) {
            return ValidationMessages.invalidCurrency;
          }
          break;

        case FieldType.description:
        case FieldType.multiline:
          if (trimmedValue.length < 10) {
            return '$label should be at least 10 characters';
          }
          break;

        case FieldType.location:
          if (trimmedValue.length < 2) {
            return 'Location must be at least 2 characters';
          }
          if (RegExp(r'\d').hasMatch(trimmedValue)) {
            return 'Location should not contain numbers';
          }
          break;

        case FieldType.password:
          if (trimmedValue.length < 8) {
            return 'Password must be at least 8 characters';
          }
          break;

        default:
          break;
      }

      return null;
    };
  }
}


