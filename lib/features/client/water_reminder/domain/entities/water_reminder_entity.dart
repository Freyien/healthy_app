import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/extensions/datetime.dart';

class WaterReminderEntity extends Equatable {
  final int minuteInterval;
  final DateTime start;
  final DateTime end;
  final bool enable;
  final DateTime lastEventDate;

  WaterReminderEntity({
    required this.minuteInterval,
    required this.start,
    required this.end,
    required this.enable,
    required this.lastEventDate,
  });

  factory WaterReminderEntity.initial() {
    final now = DateTime.now();

    return WaterReminderEntity(
      minuteInterval: 120,
      start: now.copyWith(hour: 7, minute: 0),
      end: now.copyWith(hour: 23, minute: 0),
      enable: false,
      lastEventDate: now,
    );
  }

  int get intervalToSeconds => minuteInterval * 60;

  // TODO: Delete
  DateTime get reminderStart {
    final now = DateTime.now();

    return now.removeTime().copyWith(
          hour: start.hour,
          minute: start.hour,
        );
  }

  DateTime get reminderEnd {
    final now = DateTime.now();

    return now.removeTime().copyWith(
          hour: end.hour,
          minute: end.hour,
        );
  }

  DateTime get scheduleDate {
    DateTime date = lastEventDate.add(
      Duration(minutes: minuteInterval),
    );

    // Sumar intervalo para que la fecha sea después de la fecha/hora actual
    final now = DateTime.now();
    while (date.isBefore(now)) {
      date = date.add(
        Duration(minutes: minuteInterval),
      );
    }

    // Si la hora es después de la hora límite
    // entonces programar para mañana a la hr inicial
    if (date.isAfter(reminderEnd)) {
      date = reminderStart.add(Duration(days: 1));
    }

    return date;
  }

  WaterReminderEntity copyWith({
    int? minuteInterval,
    DateTime? start,
    DateTime? end,
    bool? enable,
    DateTime? lastEventDate,
  }) {
    return WaterReminderEntity(
      minuteInterval: minuteInterval ?? this.minuteInterval,
      start: start ?? this.start,
      end: end ?? this.end,
      enable: enable ?? this.enable,
      lastEventDate: lastEventDate ?? this.lastEventDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minuteInterval': minuteInterval,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'enable': enable,
    };
  }

  factory WaterReminderEntity.fromMap(Map<String, dynamic> map) {
    if (map['minuteInterval'] == null) return WaterReminderEntity.initial();

    return WaterReminderEntity(
      minuteInterval: map['minuteInterval'],
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] * 1000),
      end: DateTime.fromMillisecondsSinceEpoch(map['end'] * 1000),
      enable: map['enable'],
      lastEventDate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        minuteInterval,
        start,
        end,
        lastEventDate,
        enable,
      ];
}
