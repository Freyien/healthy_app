import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/repositories/eating_plan_repository.dart';

class EatingPlanRepositoryImpl implements EatingPlanRepository {
  final CloudClient _client;

  EatingPlanRepositoryImpl(this._client);

  @override
  Future<Response<EatingPlanEntity>> getEatingPlan(DateTime date) async {
    try {
      final result = await _client.get(
        'getEatingPlanClient',
        useCache: false,
        parameters: {
          'milliseconds': date.removeTime().millisecondsSinceEpoch,
        },
      );

      final eatingPlan = EatingPlanEntity.fromMap(result);

      return Response.success(eatingPlan);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> checkFoodOption(
    String foodCheckedId,
    FoodBlockEntity foodBlock,
    bool checked,
  ) async {
    try {
      await _client.post(
        'checkFoodOption',
        parameters: {
          'foodCheckedId': foodCheckedId,
          'foodBlockId': foodBlock.id,
          'checked': checked,
        },
      );

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
