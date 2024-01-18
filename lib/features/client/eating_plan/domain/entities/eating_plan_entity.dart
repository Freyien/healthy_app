import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_checked_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/plan_block_entity.dart';

class EatingPlanEntity extends Equatable {
  final String id;
  final num water;
  final List<PlanBlockEntity> planBlockList;
  final FoodCheckedEntity foodChecked;

  const EatingPlanEntity({
    required this.id,
    required this.water,
    required this.planBlockList,
    required this.foodChecked,
  });

  factory EatingPlanEntity.initial() => EatingPlanEntity(
        id: '',
        water: 0,
        planBlockList: [],
        foodChecked: FoodCheckedEntity.initial(),
      );

  EatingPlanEntity copyWith({
    String? id,
    num? water,
    List<PlanBlockEntity>? planBlockList,
    FoodCheckedEntity? foodChecked,
  }) {
    return EatingPlanEntity(
      id: id ?? this.id,
      water: water ?? this.water,
      planBlockList: planBlockList ?? this.planBlockList,
      foodChecked: foodChecked ?? this.foodChecked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'water': water,
      'foodBlockList': planBlockList.map((x) => x.toMap()).toList(),
    };
  }

  factory EatingPlanEntity.fromMap(Map<String, dynamic> map) {
    if (map['id'] == null) return EatingPlanEntity.initial();

    return EatingPlanEntity(
      id: map['id'] as String,
      water: map['water'],
      planBlockList: List<PlanBlockEntity>.from(
        map['foodBlockList'].map(
          (x) => PlanBlockEntity.fromMap(
            Map<String, dynamic>.from(x),
          ),
        ),
      ),
      foodChecked: FoodCheckedEntity.fromMap(
        Map<String, dynamic>.from(map['foodChecked']),
      ),
    );
  }

  EatingPlanEntity checkFoodBlockList() {
    final planBlockListClone = planBlockList.map((planBlock) {
      final foodBlockClone = planBlock.foodBlockList.map((foodBlock) {
        final checked = foodBlockIsChecked(foodBlock);

        return foodBlock.copyWith(checked: checked);
      }).toList();

      return planBlock.copyWith(foodBlockList: foodBlockClone);
    }).toList();

    return this.copyWith(planBlockList: planBlockListClone);
  }

  bool foodBlockIsChecked(FoodBlockEntity foodBlock) {
    return foodChecked.checked[foodBlock.id] ?? false;
  }

  EatingPlanEntity checkFoodBlock(String foodBlockId, bool checked) {
    final newPlanBlockList = planBlockList.map((planBlock) {
      final newFoodBlockList = planBlock.foodBlockList.map((foodBlock) {
        if (foodBlock.id == foodBlockId) //
          return foodBlock.copyWith(checked: checked);

        return foodBlock;
      }).toList();

      return planBlock.copyWith(foodBlockList: newFoodBlockList);
    }).toList();

    return copyWith(planBlockList: newPlanBlockList);
  }

  @override
  List<Object> get props => [id, water, planBlockList, foodChecked];
}
