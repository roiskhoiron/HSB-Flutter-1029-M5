import 'package:travel_planner/core/security/input_sanitizer.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    try {
      InputSanitizer.sanitizeEmail(value);
      return null;
    } catch (e) {
      return 'Please enter a valid email address';
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (value.length > 128) {
      return 'Password is too long';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    try {
      final sanitized = InputSanitizer.sanitizeName(value);
      if (sanitized.isEmpty) {
        return 'Name cannot be empty';
      }
      return null;
    } catch (e) {
      return 'Please enter a valid name';
    }
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static bool isValidEmail(String email) {
    return validateEmail(email) == null;
  }

  static bool isValidPassword(String password) {
    return validatePassword(password) == null;
  }

  static bool isValidName(String name) {
    return validateName(name) == null;
  }
}
