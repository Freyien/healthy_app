part of 'water_reminder_bloc.dart';

sealed class WaterReminderEvent extends Equatable {
  const WaterReminderEvent();

  @override
  List<Object> get props => [];
}

class GetWaterReminderEvent extends WaterReminderEvent {
  GetWaterReminderEvent();
}

class ChangeEnableEvent extends WaterReminderEvent {
  final bool value;

  ChangeEnableEvent(this.value);
}

class ChangeIntervalEvent extends WaterReminderEvent {
  final int value;

  ChangeIntervalEvent(this.value);
}

class ChangeStartTimeEvent extends WaterReminderEvent {
  final DateTime value;

  ChangeStartTimeEvent(this.value);
}

class ChangeEndTimeEvent extends WaterReminderEvent {
  final DateTime value;

  ChangeEndTimeEvent(this.value);
}

class SaveEvent extends WaterReminderEvent {
  SaveEvent();
}
