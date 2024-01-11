part of 'eating_plan_bloc.dart';

sealed class EatingPlanEvent extends Equatable {
  const EatingPlanEvent();

  @override
  List<Object> get props => [];
}

class GetEatingPlanEvent extends EatingPlanEvent {
  final DateTime date;

  GetEatingPlanEvent(this.date);
}

class CheckFoodEvent extends EatingPlanEvent {
  final FoodBlockEntity foodBlock;
  final bool checked;

  CheckFoodEvent(this.foodBlock, this.checked);
}
