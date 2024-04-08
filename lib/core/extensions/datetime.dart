import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formated() => DateFormat.yMMMMd('es').format(this);

  String format(String format) {
    final formatter = DateFormat(format, 'es_MX');
    return formatter.format(this);
  }

  DateTime addTime({
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  }) =>
      DateTime(
        year + years,
        month + months,
        day + days,
        hour + hours,
        minute + minutes,
        second + seconds,
        millisecond,
        microsecond,
      );

  DateTime sustractTime({
    int years = 0,
    int months = 0,
    int days = 0,
  }) =>
      DateTime(
        year - years,
        month - months,
        day - days,
        hour,
        minute,
        millisecond,
        microsecond,
      );

  DateTime removeTime() =>
      DateTime(this.year, this.month, this.day, 0, 0, 0, 0);

  bool isEqualWithOuTime(DateTime date) => this.compareTo(date) == 0;
}
