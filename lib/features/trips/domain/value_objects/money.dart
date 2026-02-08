import 'package:travel_planner/core/constants/app_constants.dart';

class Money {
  final int cents; // Store as cents (integer) - no floating point errors!
  final String currency;

  const Money(this.cents, this.currency);

  factory Money.usd(double amount) =>
      Money((amount * 100).round(), AppConstants.defaultCurrencyCode);

  factory Money.fromAmount(double amount, String currency) =>
      Money((amount * 100).round(), currency);

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
