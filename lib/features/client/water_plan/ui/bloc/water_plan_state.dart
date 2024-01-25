part of 'water_plan_bloc.dart';

class WaterPlanState extends Equatable {
  const WaterPlanState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.deletingStatus,
    required this.waterPlan,
    required this.date,
    required this.minDate,
    required this.maxDate,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final DeletingStatus deletingStatus;

  final WaterPlanEntity waterPlan;
  final DateTime date;
  final DateTime minDate;
  final DateTime maxDate;

  factory WaterPlanState.initial() {
    final now = DateTime.now();
    final date = now.addTime(months: 2);
    int addedDays = 0;

    addedDays = date.weekday < 7 //
        ? 6 - date.weekday
        : 6;

    final maxDate = date.addTime(days: addedDays);

    return WaterPlanState(
        fetchingStatus: FetchingStatus.initial,
        savingStatus: SavingStatus.initial,
        deletingStatus: DeletingStatus.initial,
        waterPlan: WaterPlanEntity.initial(),
        date: now,
        minDate: DateTime(2023, 12, 31),
        maxDate: maxDate);
  }

  WaterPlanState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    DeletingStatus? deletingStatus,
    WaterPlanEntity? waterPlan,
    DateTime? date,
  }) {
    return WaterPlanState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      deletingStatus: deletingStatus ?? this.deletingStatus,
      waterPlan: waterPlan ?? this.waterPlan,
      date: date ?? this.date,
      minDate: this.minDate,
      maxDate: this.maxDate,
    );
  }

  @override
  List<Object> get props {
    return [
      fetchingStatus,
      savingStatus,
      deletingStatus,
      waterPlan,
      date,
      minDate,
      maxDate,
    ];
  }
}
