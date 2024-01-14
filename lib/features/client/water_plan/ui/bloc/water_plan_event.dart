part of 'water_plan_bloc.dart';

sealed class WaterPlanEvent extends Equatable {
  const WaterPlanEvent();

  @override
  List<Object> get props => [];
}

class GetWaterPlanEvent extends WaterPlanEvent {
  final DateTime date;

  GetWaterPlanEvent(this.date);
}

class AddWaterConsumptionEvent extends WaterPlanEvent {
  final int waterConsumption;

  AddWaterConsumptionEvent(this.waterConsumption);
}

class DeleteWaterConsumptionEvent extends WaterPlanEvent {
  final WaterConsumptionEntity waterConsumption;

  DeleteWaterConsumptionEvent(this.waterConsumption);
}
