import 'package:travel_planner/core/constants/app_constants.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';
import 'package:intl/intl.dart';

class MultiCurrencyService {
  static Money create(
    double amount, {
    String currency = AppConstants.defaultCurrencyCode,
  }) {
    return Money.fromAmount(amount, currency);
  }

  static String formatAmount(Money money, {String locale = 'en'}) {
    switch (locale.toLowerCase()) {
      case 'es':
        final symbol = formatSymbol('es');
        return '$symbol${money.amountString.replaceAll('.', ',')}';
      case 'id':
        final symbol = formatSymbol('id');
        return '$symbol${money.amountString.replaceAll('.', ',').replaceAll('.00', '')}';
      default:
        return '${AppConstants.defaultCurrencySymbol}${money.amountString}';
    }
  }

  static String formatSymbol(String locale) {
    return AppConstants.currencySymbols[locale.toLowerCase()] ??
        AppConstants.defaultCurrencySymbol;
  }

  static String formatDate(DateTime date, {String locale = 'en'}) {
    return DateFormat.yMd(locale).format(date);
  }
}
