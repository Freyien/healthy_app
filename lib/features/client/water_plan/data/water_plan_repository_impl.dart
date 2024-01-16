import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/repositories/water_plan_repository.dart';

class WaterPlanRepositoryImpl implements WaterPlanRepository {
  final CloudClient _client;

  WaterPlanRepositoryImpl(this._client);
  @override
  Future<Response<WaterPlanEntity>> getWaterPlan(DateTime date) async {
    try {
      final result = await _client.get(
        'getWaterPlan',
        useCache: false,
        parameters: {
          'milliseconds': date.removeTime().millisecondsSinceEpoch,
        },
      );

      final waterPlan = WaterPlanEntity.fromMap(result);

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
      final result = await _client.post(
        'addWaterConsumption',
        parameters: {
          'waterPlanId': waterPlanId,
          'quantity': quantity,
        },
      );

      final waterConsumption = WaterConsumptionEntity.fromMap(result);

      return Response.success(waterConsumption);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> deleteWaterConsumption(String id) async {
    try {
      await _client.post(
        'deleteWaterConsumption',
        parameters: {
          'id': id,
        },
      );

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
