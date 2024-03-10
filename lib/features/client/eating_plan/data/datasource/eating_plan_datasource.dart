import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';

abstract class EatingPlanDatasource {
  Future<EatingPlanEntity> getEatingPlan(DateTime date);
  Future<void> checkFoodOption(
    String foodCheckedId,
    FoodBlockEntity foodBlock,
    bool checked,
  );
}
