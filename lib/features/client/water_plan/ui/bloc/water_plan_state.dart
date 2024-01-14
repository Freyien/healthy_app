part of 'water_plan_bloc.dart';

class WaterPlanState extends Equatable {
  const WaterPlanState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.deletingStatus,
    required this.waterPlan,
    required this.date,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final DeletingStatus deletingStatus;

  final WaterPlanEntity waterPlan;
  final DateTime date;

  factory WaterPlanState.initial() => WaterPlanState(
        fetchingStatus: FetchingStatus.initial,
        savingStatus: SavingStatus.initial,
        deletingStatus: DeletingStatus.initial,
        waterPlan: WaterPlanEntity.initial(),
        date: DateTime.now(),
      );

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
    ];
  }
}
