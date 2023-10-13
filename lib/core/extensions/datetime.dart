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
  }) =>
      DateTime(
        year + years,
        month + months,
        day + days,
        hour,
        minute,
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
}
