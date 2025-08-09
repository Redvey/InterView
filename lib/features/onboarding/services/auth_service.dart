// features/auth/services/auth_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _keyIsAuthenticated = 'is_authenticated';
  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyCurrentUser = 'current_user';
  static const String _keyUserToken = 'user_token';

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsAuthenticated) ?? false;
  }

  // Check if it's user's first time
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsFirstTime) ?? true;
  }

  // Complete onboarding
  static Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsFirstTime, false);
  }

  // Login user
  static Future<User> login(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with actual API call
    // For now, simulate successful login
    if (email.isNotEmpty && password.isNotEmpty) {
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        fullName: 'Demo User', // This would come from API
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _saveUserSession(user, 'demo_token_${user.id}');
      return user;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  // Complete signup with full user data
  static Future<User> completeSignup(User user) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace with actual API call
    // For now, simulate successful signup
    final completeUser = user.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final token = 'demo_token_${completeUser.id}';
    await _saveUserSession(completeUser, token);

    return completeUser;
  }

  // Save user session data
  static Future<void> _saveUserSession(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setBool(_keyIsAuthenticated, true),
      prefs.setBool(_keyIsFirstTime, false),
      prefs.setString(_keyCurrentUser, jsonEncode(user.toMap())),
      prefs.setString(_keyUserToken, token),
    ]);
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(_keyIsAuthenticated) ?? false;

    if (!isAuth) return null;

    final userJson = prefs.getString(_keyCurrentUser);
    if (userJson == null) return null;

    try {
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
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    final user = updatedUser.copyWith(updatedAt: DateTime.now());

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentUser, jsonEncode(user.toMap()));

    return user;
  }

  // Logout user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setBool(_keyIsAuthenticated, false),
      prefs.remove(_keyCurrentUser),
      prefs.remove(_keyUserToken),
    ]);
  }

  // Get user token
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserToken);
  }

  // Reset password (placeholder)
  static Future<void> resetPassword(String email) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Implement actual password reset
    print('Password reset requested for: $email');
  }

  // Change password
  static Future<void> changePassword(String currentPassword, String newPassword) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: Implement actual password change
    if (currentPassword.isEmpty || newPassword.isEmpty) {
      throw Exception('Passwords cannot be empty');
    }

    if (newPassword.length < 8) {
      throw Exception('New password must be at least 8 characters');
    }

    // Success - no exception thrown
  }

  // Delete account
  static Future<void> deleteAccount() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Implement actual account deletion
    await logout();
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

// Auth exceptions for better error handling
class AuthException implements Exception {
  final String message;
  final String code;

  const AuthException(this.message, this.code);

  @override
  String toString() => 'AuthException: $message (Code: $code)';
}

// Common auth exception types
class AuthExceptions {
  static const AuthException invalidCredentials = AuthException(
      'Invalid email or password',
      'INVALID_CREDENTIALS'
  );

  static const AuthException userNotFound = AuthException(
      'User not found',
      'USER_NOT_FOUND'
  );

  static const AuthException emailAlreadyExists = AuthException(
      'Email already exists',
      'EMAIL_EXISTS'
  );

  static const AuthException weakPassword = AuthException(
      'Password is too weak',
      'WEAK_PASSWORD'
  );

  static const AuthException networkError = AuthException(
      'Network error occurred',
      'NETWORK_ERROR'
  );
}