class InputValidators {
  static String? required(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? number(String? value, {String fieldName = "Number"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    final numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value.trim())) {
      return "Only digits are allowed";
    }
    return null;
  }

  static String? minLength(String? value, int minLen,
      {String fieldName = "Field"}) {
    if (value == null || value.length < minLen) {
      return "$fieldName must be at least $minLen characters";
    }
    return null;
  }
}
