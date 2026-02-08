import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateFormatter {
  static String formatDate(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.yMd(locale).format(date);
    }
    return DateFormat.yMd().format(date);
  }

  static String formatTime(DateTime time, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.jm(locale).format(time);
    }
    return DateFormat.jm().format(time);
  }

  static String formatDateTime(DateTime dateTime, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.yMd(locale).add_jm().format(dateTime);
    }
    return DateFormat.yMd().add_jm().format(dateTime);
  }

  static String formatFullDate(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.yMMMMd(locale).add_y().format(date);
    }
    return DateFormat.yMMMMd().add_y().format(date);
  }

  static String formatFullDateTime(DateTime dateTime, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.yMMMMd(locale).add_y().add_jm().format(dateTime);
    }
    return DateFormat.yMMMMd().add_y().add_jm().format(dateTime);
  }

  static String formatRelativeDate(DateTime date, {BuildContext? context}) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else {
      return '${(difference.inDays / 365).floor()}y ago';
    }
  }

  static String formatShortDate(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.Md(locale).format(date);
    }
    return DateFormat.Md().format(date);
  }

  static String formatShortTime(DateTime time, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.Hm(locale).format(time);
    }
    return DateFormat.Hm().format(time);
  }

  static String formatMonthYear(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.yMMMM(locale).format(date);
    }
    return DateFormat.yMMMM().format(date);
  }

  static String formatWeekday(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.E(locale).format(date);
    }
    return DateFormat.E().format(date);
  }

  static String formatDay(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.d(locale).format(date);
    }
    return DateFormat.d().format(date);
  }

  static String formatYear(DateTime date, {BuildContext? context}) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return DateFormat.y(locale).format(date);
    }
    return DateFormat.y().format(date);
  }

  static String getLocalizedDateString(DateTime date, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final now = DateTime.now();

    if (date.year == now.year) {
      if (locale.languageCode == 'es') {
        return '${_getSpanishMonth(date.month)} ${date.day}, ${date.year}';
      } else if (locale.languageCode == 'id') {
        return '${date.day} ${_getIndonesianMonth(date.month)} ${date.year}';
      } else {
        return DateFormat.MMMd(locale).format(date);
      }
    } else {
      if (locale.languageCode == 'es') {
        return '${date.day} de ${_getSpanishMonth(date.month)} de ${date.year}';
      } else if (locale.languageCode == 'id') {
        return '${date.day} ${_getIndonesianMonth(date.month)} ${date.year}';
      } else {
        return DateFormat.yMMMd(locale).format(date);
      }
    }
  }

  static String _getSpanishMonth(int month) {
    const months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    return months[month - 1];
  }

  static String _getIndonesianMonth(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  static String getTimeAgo(DateTime date, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final locale = Localizations.localeOf(context);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return _getJustNowText(locale);
        }
        return '${difference.inMinutes}${_getMinutesText(locale)}';
      }
      return '${difference.inHours}${_getHoursText(locale)}';
    } else if (difference.inDays == 1) {
      return _getYesterdayText(locale);
    } else if (difference.inDays < 7) {
      return '${difference.inDays}${_getDaysText(locale)}';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}${_getWeeksText(locale)}';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}${_getMonthsText(locale)}';
    } else {
      return '${(difference.inDays / 365).floor()}${_getYearsText(locale)}';
    }
  }

  static String _getJustNowText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'Ahora mismo';
      case 'id':
        return 'Baru saja';
      default:
        return 'Just now';
    }
  }

  static String _getMinutesText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'min';
      case 'id':
        return 'menit';
      default:
        return 'm';
    }
  }

  static String _getHoursText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'h';
      case 'id':
        return 'jam';
      default:
        return 'h';
    }
  }

  static String _getYesterdayText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'Ayer';
      case 'id':
        return 'Kemarin';
      default:
        return 'Yesterday';
    }
  }

  static String _getDaysText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'd';
      case 'id':
        return 'hari';
      default:
        return 'd';
    }
  }

  static String _getWeeksText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'sem';
      case 'id':
        return 'minggu';
      default:
        return 'w';
    }
  }

  static String _getMonthsText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'mes';
      case 'id':
        return 'bulan';
      default:
        return 'mo';
    }
  }

  static String _getYearsText(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return 'a';
      case 'id':
        return 'tahun';
      default:
        return 'y';
    }
  }
}
