import 'package:intl/intl.dart';
import 'package:optimus_case/enums/app_locale.dart';
import 'package:optimus_case/utils/date_format_pattern.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedMonthDayYear() {
    return DateFormat(
            DateFormatPattern.dayMonthYear, AppLocale.dateFormatPattern)
        .format(this);
  }

  String toFormattedTime() {
    return DateFormat(DateFormatPattern.time, AppLocale.dateFormatPattern)
        .format(this);
  }

  String toFormattedDayWithUtcOffset(String utcOffset) {
    String dayName =
        DateFormat(DateFormatPattern.dayName, AppLocale.dateFormatPattern)
            .format(this);
    String formattedOffset = _formatUtcOffset(utcOffset);
    return "$dayName, GMT $formattedOffset";
  }

  String toFormattedDateTime() {
    return DateFormat(DateFormatPattern.dateTime, AppLocale.dateFormatPattern)
        .format(this);
  }

  String toHumanReadableString() {
    return DateFormat(DateFormatPattern.dateTime, AppLocale.dateFormatPattern)
        .format(this);
  }

  DateTime addTimeZoneOffset() {
    return add(Duration(seconds: timeZoneOffset.inSeconds));
  }

  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  // UTC offset formatlama: "+03:00" veya "-02:30"
  String _formatUtcOffset(String utcOffset) {
    if (!utcOffset.startsWith("+") && !utcOffset.startsWith("-")) {
      utcOffset = "+$utcOffset";
    }
    return utcOffset;
  }

  // 2 basamağa tamamlar: 1 -> "01"
  String asTwoDigits() {
    return toString().padLeft(2, '0');
  }
}
