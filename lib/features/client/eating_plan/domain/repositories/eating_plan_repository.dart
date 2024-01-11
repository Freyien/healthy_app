import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';

abstract class EatingPlanRepository {
  Future<Response<EatingPlanEntity>> getEatingPlan(DateTime date);
  Future<Response<void>> checkFoodOption(
    String foodCheckedId,
    FoodBlockEntity foodBlock,
    bool checked,
  );
}
