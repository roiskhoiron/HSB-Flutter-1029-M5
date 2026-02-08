class InputSanitizer {
  static String sanitizeEmail(String email) {
    if (email.isEmpty) return '';

    email = email.toLowerCase().trim();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      throw const FormatException('Invalid email format');
    }

    return email
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '');
  }

  static String sanitizeName(String name) {
    if (name.isEmpty) return '';

    name = name.trim();

    name = name.replaceAll(RegExp(r'<[^>]*>'), '');
    name = name
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '');

    if (name.length > 100) {
      name = name.substring(0, 100);
    }

    return name;
  }

  static String sanitizePassword(String password) {
    if (password.length < 6) {
      throw const FormatException('Password must be at least 6 characters');
    }

    if (password.length > 128) {
      throw const FormatException('Password too long');
    }

    return password;
  }

  static bool isValidEmail(String email) {
    try {
      sanitizeEmail(email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidName(String name) {
    try {
      sanitizeName(name);
      return name.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
