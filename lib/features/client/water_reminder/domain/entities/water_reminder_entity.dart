import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/extensions/datetime.dart';

class WaterReminderEntity extends Equatable {
  final int minuteInterval;
  final DateTime start;
  final DateTime end;
  final bool enable;

  WaterReminderEntity({
    required this.minuteInterval,
    required this.start,
    required this.end,
    required this.enable,
  });

  factory WaterReminderEntity.initial() {
    final now = DateTime.now();

    return WaterReminderEntity(
      minuteInterval: 120,
      start: now.copyWith(hour: 7, minute: 0),
      end: now.copyWith(hour: 23, minute: 0),
      enable: false,
    );
  }

  int get intervalToSeconds => minuteInterval * 60;

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

  int get calculateNextSecondsReminder {
    final now = DateTime.now();

    // Sumar intervalo a hr actual
    DateTime date = now.add(Duration(minutes: minuteInterval));

    // Si pasa de la hr límite entonces programar para mañana
    if (date.isAfter(reminderEnd)) {
      final tomorrow = reminderStart.add(Duration(days: 1));

      // Diferencia entre fecha calculada y fecha de inicio
      return tomorrow.difference(date).inSeconds;
    }

    return intervalToSeconds;
  }

  WaterReminderEntity copyWith({
    int? minuteInterval,
    DateTime? start,
    DateTime? end,
    bool? enable,
  }) {
    return WaterReminderEntity(
      minuteInterval: minuteInterval ?? this.minuteInterval,
      start: start ?? this.start,
      end: end ?? this.end,
      enable: enable ?? this.enable,
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

  factory WaterReminderEntity.fromMap(
    Map<String, dynamic> map, {
    bool fromTimestamp = true,
  }) {
    if (map['minuteInterval'] == null) return WaterReminderEntity.initial();

    final multiplier = fromTimestamp ? 1000 : 1;

    final start =
        DateTime.fromMillisecondsSinceEpoch(map['start'] * multiplier);
    final end = DateTime.fromMillisecondsSinceEpoch(map['end'] * multiplier);

    return WaterReminderEntity(
      minuteInterval: map['minuteInterval'],
      start: DateTime.now().removeTime().copyWith(
            hour: start.hour,
            minute: start.minute,
          ),
      end: DateTime.now().removeTime().copyWith(
            hour: end.hour,
            minute: end.minute,
          ),
      enable: map['enable'],
    );
  }

  @override
  List<Object?> get props => [
        minuteInterval,
        start,
        end,
        enable,
      ];
}
