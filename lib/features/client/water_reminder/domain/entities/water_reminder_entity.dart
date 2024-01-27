import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';

class WaterReminderEntity extends Equatable {
  final int minuteInterval;
  final DateTime start;
  final DateTime end;
  final bool enable;
  final WaterConsumptionEntity? waterConsumption;

  WaterReminderEntity({
    required this.minuteInterval,
    required this.start,
    required this.end,
    required this.enable,
    this.waterConsumption,
  });

  factory WaterReminderEntity.initial() => WaterReminderEntity(
        minuteInterval: 120,
        start: DateTime.now().copyWith(hour: 7, minute: 0),
        end: DateTime.now().copyWith(hour: 23, minute: 0),
        enable: false,
      );

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

  DateTime get nextScheduledDate {
    final waterConsumptionDate = waterConsumption?.date.add(
      Duration(minutes: minuteInterval),
    );

    DateTime scheduledDate = waterConsumptionDate ?? reminderStart;

    // Sumar intervalo para que la fecha sea después de la fecha/hora actual
    final now = DateTime.now();
    while (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(
        Duration(minutes: minuteInterval),
      );
    }

    // Si la hora es después de la hora límite
    // entonces programar para mañana a la hr inicial
    if (scheduledDate.isAfter(reminderEnd)) {
      scheduledDate = reminderStart.add(Duration(days: 1));
    }

    return scheduledDate;
  }

  WaterReminderEntity copyWith({
    int? minuteInterval,
    DateTime? start,
    DateTime? end,
    bool? enable,
    WaterConsumptionEntity? waterConsumption,
  }) {
    return WaterReminderEntity(
      minuteInterval: minuteInterval ?? this.minuteInterval,
      start: start ?? this.start,
      end: end ?? this.end,
      enable: enable ?? this.enable,
      waterConsumption: waterConsumption ?? this.waterConsumption,
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
    );
  }

  @override
  List<Object?> get props => [
        minuteInterval,
        start,
        end,
        waterConsumption,
        enable,
      ];
}
