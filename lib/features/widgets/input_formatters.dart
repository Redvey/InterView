import 'package:flutter/services.dart';

class InputFormatters {
  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;

  static final noSpaces = FilteringTextInputFormatter.deny(RegExp(r'\s'));

  static TextInputFormatter maxLength(int maxLen) =>
      LengthLimitingTextInputFormatter(maxLen);

  static TextInputFormatter allowRegex(RegExp pattern) =>
      FilteringTextInputFormatter.allow(pattern);
}
