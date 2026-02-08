class ValidationConstants {
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;

  static const int minTripTitleLength = 3;
  static const int maxTripTitleLength = 100;
  static const int minDescriptionLength = 10;
  static const int maxDescriptionLength = 500;
  static const int maxDestinationLength = 100;

  static const int minBudgetAmountCents = 0; // $0.00 in cents
  static const int maxBudgetAmountCents = 99999999; // $999,999.99 in cents

  static const int maxTripDurationDays = 365;
  static const int minTripDurationDays = 1;

  // Regex patterns
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String numericRegex = r'^[0-9]+$';
  static const String alphanumericRegex = r'^[a-zA-Z0-9]+$';
  static const String phoneRegex = r'^\+?[\d\s\-\(\)]+$';

  static const int minNameLength = 2;
  static const int maxNameLength = 50;
}
