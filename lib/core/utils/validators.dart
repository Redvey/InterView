
import 'package:flutter/services.dart';

class FormValidationUtils {
  // Email validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email.trim());
  }

  // Phone validation (US format)
  static bool isValidPhone(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length != 10) return false;

    // Check for obviously invalid patterns
    if (RegExp(r'^(\d)\1{9}$').hasMatch(digitsOnly)) return false;
    if (digitsOnly.startsWith('0') || digitsOnly.startsWith('1')) return false;

    return true;
  }

  // URL validation
  static bool isValidUrl(String url) {
    String testUrl = url.trim();
    if (!testUrl.startsWith('http://') && !testUrl.startsWith('https://')) {
      testUrl = 'https://$testUrl';
    }
    return RegExp(r'^https?:\/\/[^\s/$.?#].[^\s]*$').hasMatch(testUrl);
  }

  // GitHub URL validation
  static bool isValidGitHubUrl(String url) {
    if (!isValidUrl(url)) return false;
        final uri = Uri.tryParse(url.toLowerCase());
        return uri != null && uri.host == 'github.com';
  }

  // LinkedIn URL validation
  static bool isValidLinkedInUrl(String url) {
    if (!isValidUrl(url)) return false;
        final uri = Uri.tryParse(url.toLowerCase());
        return uri != null && (uri.host == 'linkedin.com' || uri.host == 'www.linkedin.com');
  }

  // Currency validation
  static bool isValidCurrency(String amount) {
    return RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(amount.trim());
  }

  // Name validation (no numbers, reasonable length)
  static bool isValidName(String name) {
    final trimmed = name.trim();
    return trimmed.length >= 2 &&
        trimmed.length <= 50 &&
        !RegExp(r'\d').hasMatch(trimmed);
  }

  // Experience validation (0-99 years)
  static bool isValidExperience(String experience) {
    final exp = int.tryParse(experience.trim());
    return exp != null && exp >= 0 && exp <= 99;
  }
}

class FormFormatters {
  // Phone number formatter: XXX-XXX-XXXX
  static TextInputFormatter phoneFormatter() {
    return _PhoneNumberFormatter();
  }

  // Capitalize each word
  static TextInputFormatter capitalizeWordsFormatter() {
    return _CapitalizeWordsFormatter();
  }

  // Lowercase formatter (for emails, URLs)
  static TextInputFormatter lowercaseFormatter() {
    return _LowercaseFormatter();
  }

  // Currency formatter (max 2 decimal places)
  static TextInputFormatter currencyFormatter() {
    return _CurrencyFormatter();
  }

  // URL formatter (basic cleanup)
  static TextInputFormatter urlFormatter() {
    return _UrlFormatter();
  }
}

// Custom Input Formatters Implementation
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length <= 10) {
      String formatted = digits;

      if (digits.length >= 6) {
        formatted = '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
      } else if (digits.length >= 3) {
        formatted = '${digits.substring(0, 3)}-${digits.substring(3)}';
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    return oldValue;
  }
}

class _CapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text;

    if (newText.isNotEmpty) {
      final words = newText.split(' ');
      final capitalizedWords = words.map((word) {
        if (word.isNotEmpty) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        }
        return word;
      }).toList();

      newText = capitalizedWords.join(' ');
    }

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}

class _LowercaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class _CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text;

    // Prevent multiple decimal points
    if (newText.split('.').length > 2) {
      return oldValue;
    }

    // Limit decimal places to 2
    if (newText.contains('.')) {
      final parts = newText.split('.');
      if (parts[1].length > 2) {
        newText = '${parts[0]}.${parts[1].substring(0, 2)}';
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class _UrlFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text.trim();

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}

// Common validation messages
class ValidationMessages {
  static const String required = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String invalidPhone = 'Please enter a valid 10-digit phone number';
  static const String invalidUrl = 'Please enter a valid URL';
  static const String invalidGitHub = 'Please enter a valid GitHub URL';
  static const String invalidLinkedIn = 'Please enter a valid LinkedIn URL';
  static const String nameTooShort = 'Name must be at least 2 characters';
  static const String nameNoNumbers = 'Name should not contain numbers';
  static const String descriptionTooShort = 'Description should be at least 10 characters';
  static const String invalidExperience = 'Please enter experience between 0-99 years';
  static const String invalidCurrency = 'Please enter a valid amount';

  // Custom required message
  static String requiredField(String fieldName) => '$fieldName is required';

  // Custom minimum length message
  static String minLength(String fieldName, int minLength) =>
      '$fieldName must be at least $minLength characters';
}

// Predefined validators for common use cases
class CommonValidators {
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? ValidationMessages.requiredField(fieldName)
          : ValidationMessages.required;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    if (!FormValidationUtils.isValidEmail(value)) {
      return ValidationMessages.invalidEmail;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    if (!FormValidationUtils.isValidPhone(value)) {
      return ValidationMessages.invalidPhone;
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    if (!FormValidationUtils.isValidUrl(value)) {
      return ValidationMessages.invalidUrl;
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    if (!FormValidationUtils.isValidName(value)) {
      if (value.trim().length < 2) {
        return ValidationMessages.nameTooShort;
      }
      if (RegExp(r'\d').hasMatch(value)) {
        return ValidationMessages.nameNoNumbers;
      }
    }
    return null;
  }

  static String? experience(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    if (!FormValidationUtils.isValidExperience(value)) {
      return ValidationMessages.invalidExperience;
    }
    return null;
  }

  static String? description(String? value, {int minLength = 10}) {
    if (value == null || value.trim().isEmpty) return null;

    if (value.trim().length < minLength) {
      return ValidationMessages.minLength('Description', minLength);
    }
    return null;
  }

  // Combine multiple validators
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}

