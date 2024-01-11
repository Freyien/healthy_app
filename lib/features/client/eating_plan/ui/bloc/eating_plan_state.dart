part of 'eating_plan_bloc.dart';

class EatingPlanState extends Equatable {
  const EatingPlanState({
    required this.fetchingStatus,
    required this.eatingPlan,
    required this.date,
  });

  final FetchingStatus fetchingStatus;
  final EatingPlanEntity eatingPlan;
  final DateTime date;

  factory EatingPlanState.initial() => EatingPlanState(
        fetchingStatus: FetchingStatus.initial,
        eatingPlan: EatingPlanEntity.initial(),
        date: DateTime.now(),
      );

  EatingPlanState copyWith({
    FetchingStatus? fetchingStatus,
    EatingPlanEntity? eatingPlan,
    DateTime? date,
  }) {
    return EatingPlanState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      eatingPlan: eatingPlan ?? this.eatingPlan,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, eatingPlan, date];
}
