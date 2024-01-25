part of 'eating_plan_bloc.dart';

class EatingPlanState extends Equatable {
  const EatingPlanState({
    required this.fetchingStatus,
    required this.eatingPlan,
    required this.date,
    required this.minDate,
    required this.maxDate,
  });

  final FetchingStatus fetchingStatus;
  final EatingPlanEntity eatingPlan;
  final DateTime date;
  final DateTime minDate;
  final DateTime maxDate;

  factory EatingPlanState.initial() {
    final now = DateTime.now();
    final date = now.addTime(months: 2);
    int addedDays = 0;

    addedDays = date.weekday < 7 //
        ? 6 - date.weekday
        : 6;

    final maxDate = date.addTime(days: addedDays);

    return EatingPlanState(
      fetchingStatus: FetchingStatus.initial,
      eatingPlan: EatingPlanEntity.initial(),
      date: now,
      minDate: DateTime(2023, 12, 31),
      maxDate: maxDate,
    );
  }

  EatingPlanState copyWith({
    FetchingStatus? fetchingStatus,
    EatingPlanEntity? eatingPlan,
    DateTime? date,
  }) {
    return EatingPlanState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      eatingPlan: eatingPlan ?? this.eatingPlan,
      date: date ?? this.date,
      minDate: this.minDate,
      maxDate: this.maxDate,
    );
  }

  @override
  List<Object> get props => [
        fetchingStatus,
        eatingPlan,
        date,
        minDate,
        maxDate,
      ];
}
