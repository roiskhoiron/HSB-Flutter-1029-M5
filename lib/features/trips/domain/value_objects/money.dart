import 'package:travel_planner/core/constants/app_constants.dart';

// 💎 Penggunaan Value Object `Money` yang menyimpan data dalam satuan `cents` (integer) 
// adalah cara paling aman untuk menghindari floating point arithmetic errors. Sangat pro! 💰🛡️
class Money {
  final int cents; // Store as cents (integer) - no floating point errors!
  final String currency;

  const Money(this.cents, this.currency);

  factory Money.usd(double amount) =>
      Money((amount * 100).round(), AppConstants.defaultCurrencyCode);

  factory Money.fromAmount(double amount, String currency) =>
      Money((amount * 100).round(), currency);

  /// Robustly parse a string to a Money object.
  /// Handles commas, spaces, and currency symbols.
  static Money? tryParse(String value, [String? currency]) {
    if (value.isEmpty) return null;

    // Remove anything that isn't a digit, a period, or a minus sign
    final cleanValue = value.replaceAll(RegExp(r'[^0-9.-]'), '');

    final amount = double.tryParse(cleanValue);
    if (amount == null) return null;

    return Money.fromAmount(
      amount,
      currency ?? AppConstants.defaultCurrencyCode,
    );
  }

  /// Get amount as double for display (only when needed)
  double get amount => cents / 100.0;

  /// Get amount as string with 2 decimal places
  String get amountString => (cents / 100.0).toStringAsFixed(2);

  String get formattedAmount {
    return '${AppConstants.defaultCurrencySymbol}$amountString';
  }

  String get formattedAmountWithoutSymbol => amountString;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money && cents == other.cents && currency == other.currency;

  @override
  int get hashCode => Object.hash(cents, currency);

  @override
  String toString() => 'Money(amount: $amount, currency: $currency)';

  // Comparison operators for budget validation
  bool operator <(Money other) => cents < other.cents;
  bool operator <=(Money other) => cents <= other.cents;
  bool operator >(Money other) => cents > other.cents;
  bool operator >=(Money other) => cents >= other.cents;
}
