import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/water_plan/data/datasource/water_plan_datasource.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';

class WaterPlanServerDatasource implements WaterPlanDatasource {
  final CloudClient _client;

  WaterPlanServerDatasource(this._client);

  @override
  Future<WaterConsumptionEntity> addWaterConsumption(
    String waterPlanId,
    int quantity,
  ) async {
    final result = await _client.post(
      'addWaterConsumption',
      parameters: {
        'waterPlanId': waterPlanId,
        'quantity': quantity,
      },
    );

    final waterConsumption = WaterConsumptionEntity.fromMap(result);
    return waterConsumption;
  }

  @override
  Future<void> deleteWaterConsumption(String id) async {
    await _client.post(
      'deleteWaterConsumption',
      parameters: {
        'id': id,
      },
    );
  }

  @override
  Future<WaterPlanEntity> getWaterPlan(DateTime date) async {
    final result = await _client.get(
      'getWaterPlan',
      useCache: false,
      parameters: {
        'milliseconds': date.removeTime().millisecondsSinceEpoch,
      },
    );

    final waterPlan = WaterPlanEntity.fromMap(result);
    return waterPlan;
  }
}
