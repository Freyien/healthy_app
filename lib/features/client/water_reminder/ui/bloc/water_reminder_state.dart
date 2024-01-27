part of 'water_reminder_bloc.dart';

class WaterReminderState extends Equatable {
  const WaterReminderState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.waterReminder,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final WaterReminderEntity waterReminder;

  factory WaterReminderState.initial() => WaterReminderState(
        fetchingStatus: FetchingStatus.initial,
        savingStatus: SavingStatus.initial,
        waterReminder: WaterReminderEntity.initial(),
      );

  WaterReminderState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    WaterReminderEntity? waterReminder,
  }) {
    return WaterReminderState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      waterReminder: waterReminder ?? this.waterReminder,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, waterReminder];
}
