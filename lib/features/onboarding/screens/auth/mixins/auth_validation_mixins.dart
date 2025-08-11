
mixin AuthValidationMixin {
  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) return 'Please enter a valid email address';
    return null;
  }

  String? validatePassword(String? value, {bool isSignup = false}) {
    if (value?.isEmpty ?? true) return 'Please enter a password';
    if (isSignup) {
      if (value!.length < 8) return 'Password must be at least 8 characters';
      if (!value.contains(RegExp(r'[A-Z]'))) return 'Password must contain an uppercase letter';
      if (!value.contains(RegExp(r'[0-9]'))) return 'Password must contain a number';
    }
    return null;
  }
}
