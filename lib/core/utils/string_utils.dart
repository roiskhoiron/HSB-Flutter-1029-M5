import 'package:travel_planner/core/constants/validation_constants.dart';

class StringUtils {
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  static String capitalizeWords(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  static String truncate(String text, int length, {String suffix = '...'}) {
    if (text.length <= length) return text;
    return '${text.substring(0, length)}$suffix';
  }

  static String removeExtraWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static bool isNullOrEmpty(String? text) {
    return text == null || text.isEmpty;
  }

  static bool isNotNullOrEmpty(String? text) {
    return !isNullOrEmpty(text);
  }

  static String formatPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }

    return phone;
  }

  static String formatCurrency(double amount, {String currency = '\$'}) {
    return '$currency${amount.toStringAsFixed(2)}';
  }

  static String formatNumber(double number) {
    return number
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)},',
        );
  }

  static String getInitials(String name, {int maxInitials = 2}) {
    final words = name.trim().split(' ');
    final initials = words
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .take(maxInitials)
        .join('');
    return initials;
  }

  static bool isAlphabetic(String text) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(text);
  }

  static bool isNumeric(String text) {
    return RegExp(ValidationConstants.numericRegex).hasMatch(text);
  }

  static bool isAlphanumeric(String text) {
    return RegExp(ValidationConstants.alphanumericRegex).hasMatch(text);
  }

  static bool isValidEmail(String email) {
    return RegExp(ValidationConstants.emailRegex).hasMatch(email);
  }

  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String toSlug(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  static String randomString(
    int length, {
    bool includeNumbers = true,
    bool includeSymbols = false,
  }) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    var allowedChars = chars;
    if (includeNumbers) allowedChars += numbers;
    if (includeSymbols) allowedChars += symbols;

    final random = DateTime.now().millisecondsSinceEpoch;
    final rand = random % 1000000;

    var result = '';
    for (var i = 0; i < length; i++) {
      result += allowedChars[(rand + i) % allowedChars.length];
    }

    return result;
  }

  static String maskSensitive(
    String text, {
    int visibleChars = 4,
    String mask = '*',
  }) {
    if (text.length <= visibleChars) return text;

    final visible = text.substring(0, visibleChars);
    final masked = mask * (text.length - visibleChars);

    return '$visible$masked';
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Add emoji prefix to text
  static String addEmojiPrefix(String text, String emoji) {
    return '$emoji $text';
  }
}

/// Extension for country code to flag conversion
extension CountryFlagExtension on String {
  /// Convert country code to flag emoji (e.g., 'US'.toFlag → '🇺🇸')
  String get toFlag {
    if (length != 2) return '';
    return toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }
}
