// features/auth/services/auth_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_model.dart';


class AuthService {
  static const String _keyIsAuthenticated = 'is_authenticated';
  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyCurrentUser = 'current_user';
  static const String _keyUserToken = 'user_token';
  static const String _keyLoginAttempts = 'login_attempts';
  static const String _keyLastLoginAttempt = 'last_login_attempt';
  static const int _maxLoginAttempts = 5;
  static const int _lockoutDurationMinutes = 15;

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsAuthenticated) ?? false;
    } catch (e) {
      return false;
    }
  }

  // Check if it's user's first time
  static Future<bool> isFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsFirstTime) ?? true;
    } catch (e) {
      return true;
    }
  }

  // Complete onboarding
  static Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsFirstTime, false);
    } catch (e) {
      throw AuthException('Failed to complete onboarding', 'ONBOARDING_ERROR');
    }
  }

  // Check if account is locked due to too many failed attempts
  static Future<bool> isAccountLocked() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final attempts = prefs.getInt(_keyLoginAttempts) ?? 0;
      final lastAttempt = prefs.getInt(_keyLastLoginAttempt) ?? 0;

      if (attempts >= _maxLoginAttempts) {
        final timeSinceLastAttempt = DateTime.now().millisecondsSinceEpoch - lastAttempt;
        final lockoutDuration = _lockoutDurationMinutes * 60 * 1000;
        return timeSinceLastAttempt < lockoutDuration;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // Get remaining lockout time in minutes
  static Future<int> getRemainingLockoutTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastAttempt = prefs.getInt(_keyLastLoginAttempt) ?? 0;
      final timeSinceLastAttempt = DateTime.now().millisecondsSinceEpoch - lastAttempt;
      final lockoutDuration = _lockoutDurationMinutes * 60 * 1000;
      final remainingTime = lockoutDuration - timeSinceLastAttempt;

      return remainingTime > 0 ? (remainingTime / (60 * 1000)).ceil() : 0;
    } catch (e) {
      return 0;
    }
  }

  // Record failed login attempt
  static Future<void> _recordFailedAttempt() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentAttempts = prefs.getInt(_keyLoginAttempts) ?? 0;
      await prefs.setInt(_keyLoginAttempts, currentAttempts + 1);
      await prefs.setInt(_keyLastLoginAttempt, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Silently fail - don't block user if we can't record attempts
    }
  }

  // Clear login attempts on successful login
  static Future<void> _clearLoginAttempts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyLoginAttempts);
      await prefs.remove(_keyLastLoginAttempt);
    } catch (e) {
      // Silently fail
    }
  }

  // Login user with enhanced error handling
  static Future<User> login(String email, String password) async {
    // Input validation
    if (email.trim().isEmpty) {
      throw AuthExceptions.emptyEmail;
    }
    if (password.isEmpty) {
      throw AuthExceptions.emptyPassword;
    }

    // Check if account is locked
    if (await isAccountLocked()) {
      final remainingTime = await getRemainingLockoutTime();
      throw AuthException(
          'Too many failed attempts. Try again in $remainingTime minutes.',
          'ACCOUNT_LOCKED'
      );
    }

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Email validation
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email.trim())) {
        await _recordFailedAttempt();
        throw AuthExceptions.invalidEmail;
      }

      // Simulate authentication logic
      // In a real app, this would make an API call
      if (email.trim().toLowerCase() == 'demo@example.com' && password == 'Demo123!') {
        final user = User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email.trim().toLowerCase(),
          fullName: 'Demo User',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _saveUserSession(user, 'demo_token_${user.id}');
        await _clearLoginAttempts();
        return user;
      } else {
        await _recordFailedAttempt();
        throw AuthExceptions.invalidCredentials;
      }
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw AuthExceptions.networkError;
    }
  }

  // Social login methods
  static Future<User> loginWithGoogle() async {
    try {
      // Simulate Google OAuth flow
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual Google Sign-In
      // For now, create a demo user
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: 'user@gmail.com',
        fullName: 'Google User',
        profilePicture: 'https://via.placeholder.com/150',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _saveUserSession(user, 'google_token_${user.id}');
      await _clearLoginAttempts();
      return user;
    } catch (e) {
      throw AuthException('Google login failed', 'GOOGLE_LOGIN_ERROR');
    }
  }

  static Future<User> loginWithApple() async {
    try {
      // Simulate Apple Sign In flow
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual Apple Sign-In
      // For now, create a demo user
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: 'user@icloud.com',
        fullName: 'Apple User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _saveUserSession(user, 'apple_token_${user.id}');
      await _clearLoginAttempts();
      return user;
    } catch (e) {
      throw AuthException('Apple login failed', 'APPLE_LOGIN_ERROR');
    }
  }

  // Enhanced signup with validation
  static Future<User> signup(String name, String email, String password) async {
    // Input validation
    if (name.trim().isEmpty) {
      throw AuthException('Name is required', 'EMPTY_NAME');
    }
    if (name.trim().length < 2) {
      throw AuthException('Name must be at least 2 characters', 'INVALID_NAME');
    }
    if (email.trim().isEmpty) {
      throw AuthExceptions.emptyEmail;
    }
    if (password.isEmpty) {
      throw AuthExceptions.emptyPassword;
    }

    try {
      // Email validation
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email.trim())) {
        throw AuthExceptions.invalidEmail;
      }

      // Password validation
      if (password.length < 8) {
        throw AuthExceptions.weakPassword;
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        throw AuthException('Password must contain an uppercase letter', 'WEAK_PASSWORD');
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        throw AuthException('Password must contain a number', 'WEAK_PASSWORD');
      }

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if email already exists (simulate)
      if (email.trim().toLowerCase() == 'existing@example.com') {
        throw AuthExceptions.emailAlreadyExists;
      }

      // Create new user
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email.trim().toLowerCase(),
        fullName: name.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final token = 'signup_token_${user.id}';
      await _saveUserSession(user, token);

      return user;
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw AuthExceptions.networkError;
    }
  }

  // Social signup methods
  static Future<User> signupWithGoogle() async {
    try {
      return await loginWithGoogle(); // Same flow for signup
    } catch (e) {
      throw AuthException('Google signup failed', 'GOOGLE_SIGNUP_ERROR');
    }
  }

  static Future<User> signupWithApple() async {
    try {
      return await loginWithApple(); // Same flow for signup
    } catch (e) {
      throw AuthException('Apple signup failed', 'APPLE_SIGNUP_ERROR');
    }
  }

  // Complete signup with full user data (legacy method for compatibility)
  static Future<User> completeSignup(User user) async {
    return user; // User is already complete from signup method
  }

  // Save user session data
  static Future<void> _saveUserSession(User user, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await Future.wait([
        prefs.setBool(_keyIsAuthenticated, true),
        prefs.setBool(_keyIsFirstTime, false),
        prefs.setString(_keyCurrentUser, jsonEncode(user.toMap())),
        prefs.setString(_keyUserToken, token),
      ]);
    } catch (e) {
      throw AuthException('Failed to save user session', 'SESSION_ERROR');
    }
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isAuth = prefs.getBool(_keyIsAuthenticated) ?? false;

      if (!isAuth) return null;

      final userJson = prefs.getString(_keyCurrentUser);
      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return User.fromMap(userMap);
    } catch (e) {
      // If there's an error parsing, clear the session
      await logout();
      return null;
    }
  }

  // Update user profile
  static Future<User> updateProfile(User updatedUser) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final user = updatedUser.copyWith(updatedAt: DateTime.now());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyCurrentUser, jsonEncode(user.toMap()));

      return user;
    } catch (e) {
      throw AuthException('Failed to update profile', 'UPDATE_ERROR');
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await Future.wait([
        prefs.setBool(_keyIsAuthenticated, false),
        prefs.remove(_keyCurrentUser),
        prefs.remove(_keyUserToken),
      ]);
    } catch (e) {
      throw AuthException('Failed to logout', 'LOGOUT_ERROR');
    }
  }

  // Get user token
  static Future<String?> getUserToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyUserToken);
    } catch (e) {
      return null;
    }
  }

  // Reset password with enhanced validation
  static Future<void> resetPassword(String email) async {
    if (email.trim().isEmpty) {
      throw AuthExceptions.emptyEmail;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email.trim())) {
      throw AuthExceptions.invalidEmail;
    }

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual password reset
      // print('Password reset requested for: $email');
    } catch (e) {
      throw AuthException('Failed to reset password', 'RESET_ERROR');
    }
  }

  // Change password
  static Future<void> changePassword(String currentPassword, String newPassword) async {
    if (currentPassword.isEmpty) {
      throw AuthException('Current password is required', 'EMPTY_CURRENT_PASSWORD');
    }
    if (newPassword.isEmpty) {
      throw AuthExceptions.emptyPassword;
    }
    if (newPassword.length < 8) {
      throw AuthExceptions.weakPassword;
    }

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Implement actual password change
      // Success - no exception thrown
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw AuthException('Failed to change password', 'CHANGE_PASSWORD_ERROR');
    }
  }

  // Delete account
  static Future<void> deleteAccount() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual account deletion
      await logout();
    } catch (e) {
      throw AuthException('Failed to delete account', 'DELETE_ERROR');
    }
  }

  // Refresh user session
  static Future<bool> refreshSession() async {
    try {
      final user = await getCurrentUser();
      if (user == null) return false;

      // TODO: Refresh token with API
      // For now, just check if session is valid
      return true;
    } catch (e) {
      await logout();
      return false;
    }
  }
}

// Enhanced Auth exceptions for better error handling
class AuthException implements Exception {
  final String message;
  final String code;

  const AuthException(this.message, this.code);

  @override
  String toString() => 'AuthException: $message (Code: $code)';
}

// Common auth exception types with user-friendly messages
class AuthExceptions {
  static const AuthException invalidCredentials = AuthException(
      'Invalid email or password. Please check your credentials and try again.',
      'INVALID_CREDENTIALS'
  );

  static const AuthException userNotFound = AuthException(
      'No account found with this email address.',
      'USER_NOT_FOUND'
  );

  static const AuthException emailAlreadyExists = AuthException(
      'An account with this email already exists. Please sign in instead.',
      'EMAIL_EXISTS'
  );

  static const AuthException weakPassword = AuthException(
      'Password must be at least 8 characters long.',
      'WEAK_PASSWORD'
  );

  static const AuthException networkError = AuthException(
      'Network connection failed. Please check your internet and try again.',
      'NETWORK_ERROR'
  );

  static const AuthException emptyEmail = AuthException(
      'Please enter your email address.',
      'EMPTY_EMAIL'
  );

  static const AuthException emptyPassword = AuthException(
      'Please enter your password.',
      'EMPTY_PASSWORD'
  );

  static const AuthException invalidEmail = AuthException(
      'Please enter a valid email address.',
      'INVALID_EMAIL'
  );

  static const AuthException serverError = AuthException(
      'Server error occurred. Please try again later.',
      'SERVER_ERROR'
  );

  static const AuthException tooManyRequests = AuthException(
      'Too many requests. Please wait a moment before trying again.',
      'TOO_MANY_REQUESTS'
  );
}

// Utility class for auth validation
class AuthValidator {
  static String? validateEmail(String? email) {
    if (email?.trim().isEmpty ?? true) {
      return 'Please enter your email address';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email!.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? password, {bool isSignup = false}) {
    if (password?.isEmpty ?? true) {
      return 'Please enter a password';
    }

    if (isSignup) {
      if (password!.length < 8) {
        return 'Password must be at least 8 characters';
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain an uppercase letter';
      }
      if (!password.contains(RegExp(r'[a-z]'))) {
        return 'Password must contain a lowercase letter';
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        return 'Password must contain a number';
      }
    }

    return null;
  }

  static String? validateName(String? name) {
    if (name?.trim().isEmpty ?? true) {
      return 'Please enter your name';
    }

    if (name!.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  static String? validateConfirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword?.isEmpty ?? true) {
      return 'Please confirm your password';
    }

    if (confirmPassword != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static bool isPasswordStrong(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static double getPasswordStrength(String password) {
    double strength = 0.0;

    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.125;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.125;

    return strength.clamp(0.0, 1.0);
  }
}