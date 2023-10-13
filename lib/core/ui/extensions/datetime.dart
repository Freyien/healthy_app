import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Compares only [day], [month] and [year] of [DateTime].
  bool compareWithoutTime(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }

  String yMMMMEEEEd() {
    return DateFormat.yMMMMEEEEd('es').format(this);
  }

  // Show hour in format AM/PM
  String amPm() {
    final date = DateFormat.jm().format(this);

    return date.length == 7 //
        ? '0$date'
        : date;
  }
}
