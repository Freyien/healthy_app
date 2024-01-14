import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';

abstract class WaterPlanRepository {
  Future<Response<WaterPlanEntity>> getWaterPlan(DateTime date);
  Future<Response<WaterConsumptionEntity>> addWaterConsumption(
      String waterPlanId, int quantity);
  Future<Response<void>> deleteWaterConsumption(String id);
}
