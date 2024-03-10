import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';

abstract class WaterPlanDatasource {
  Future<WaterPlanEntity> getWaterPlan(DateTime date);
  Future<WaterConsumptionEntity> addWaterConsumption(
    String waterPlanId,
    int quantity,
  );
  Future<void> deleteWaterConsumption(String id);
}
