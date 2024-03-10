import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/eating_plan/data/datasource/eating_plan_firebase_datasource.dart';
import 'package:healthy_app/features/client/eating_plan/data/datasource/eating_plan_server_datasource.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/repositories/eating_plan_repository.dart';

class EatingPlanRepositoryImpl implements EatingPlanRepository {
  final EatingPlanFirebaseDatasource _firebase;
  final EatingPlanServerDatasource _server;

  EatingPlanRepositoryImpl(this._firebase, this._server);

  @override
  Future<Response<EatingPlanEntity>> getEatingPlan(DateTime date) async {
    try {
      final eatingPlan = await _firebase.getEatingPlan(date);

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
      await _server.checkFoodOption(foodCheckedId, foodBlock, checked);
      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
