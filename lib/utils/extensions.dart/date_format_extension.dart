import 'package:intl/intl.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/utils/date_format_pattern.dart';
import 'package:optimus_case/utils/extensions.dart/int_extension.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedDate() {
    return '${day.asTwoDigits()}.${month.asTwoDigits()}.$year';
  }

  String toFormattedDateTime() {
    return '''${day.asTwoDigits()}.${month.asTwoDigits()}.$year, ${hour.asTwoDigits()}:${minute.asTwoDigits()}''';
  }

  String toHumanReadableString() {
    return '''${day.asTwoDigits()}.${month.asTwoDigits()}.$year ${hour.asTwoDigits()}:${minute.asTwoDigits()}:${second.asTwoDigits()}''';
  }

  String get toSocialDateTime {
    final today = DateTime.now();

    if (today.day == day && today.month == month && today.year == year) {
      return '''${LocalizationStrings.today}, ${hour.asTwoDigits()}:${minute.asTwoDigits()}''';
    } else if ((today.day - 1) == day &&
        today.month == month &&
        today.year == year) {
      return '''${LocalizationStrings.yesterday}, ${hour.asTwoDigits()}:${minute.asTwoDigits()}''';
    } else {
      return DateFormat(DateFormatPattern.dateTime).format(this);
    }
  }

  String get toSocialDate {
    final today = DateTime.now();

    if (today.day == day && today.month == month && today.year == year) {
      return LocalizationStrings.today;
    } else if ((today.day - 1) == day &&
        today.month == month &&
        today.year == year) {
      return LocalizationStrings.yesterday;
    } else {
      return DateFormat(DateFormatPattern.date).format(this);
    }
  }

  DateTime addTimeZoneOffset() {
    return add(
      Duration(
        seconds: DateTime.now().timeZoneOffset.inSeconds,
      ),
    );
  }

  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}
