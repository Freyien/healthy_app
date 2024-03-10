import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/water_plan/data/datasource/water_plan_firebase_datasource.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/repositories/water_plan_repository.dart';

class WaterPlanRepositoryImpl implements WaterPlanRepository {
  final WaterPlanFirebaseDatasource _firebase;

  WaterPlanRepositoryImpl(this._firebase);
  @override
  Future<Response<WaterPlanEntity>> getWaterPlan(DateTime date) async {
    try {
      final waterPlan = await _firebase.getWaterPlan(date);

      return Response.success(waterPlan);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<WaterConsumptionEntity>> addWaterConsumption(
    String waterPlanId,
    int quantity,
  ) async {
    try {
      final waterConsumption = await _firebase.addWaterConsumption(
        waterPlanId,
        quantity,
      );

      return Response.success(waterConsumption);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> deleteWaterConsumption(String id) async {
    try {
      await _firebase.deleteWaterConsumption(id);

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
