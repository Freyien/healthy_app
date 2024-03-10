import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/eating_plan/data/datasource/eating_plan_datasource.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';

class EatingPlanServerDatasource implements EatingPlanDatasource {
  final CloudClient _client;

  EatingPlanServerDatasource(this._client);

  @override
  Future<EatingPlanEntity> getEatingPlan(DateTime date) async {
    final result = await _client.get(
      'getEatingPlanClient',
      useCache: false,
      parameters: {
        'milliseconds': date.removeTime().millisecondsSinceEpoch,
      },
    );

    final eatingPlan = EatingPlanEntity.fromMap(result);
    return eatingPlan;
  }

  @override
  Future<void> checkFoodOption(
    String foodCheckedId,
    FoodBlockEntity foodBlock,
    bool checked,
  ) async {
    await _client.post(
      'checkFoodOption',
      parameters: {
        'foodCheckedId': foodCheckedId,
        'foodBlockId': foodBlock.id,
        'checked': checked,
      },
    );
  }
}
