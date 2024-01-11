import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/utils/enum_utils.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';

class PlanBlockEntity extends Equatable {
  final String comment;
  final FoodBlockType type;
  final List<FoodBlockEntity> foodBlockList;

  const PlanBlockEntity({
    required this.comment,
    required this.type,
    required this.foodBlockList,
  });

  PlanBlockEntity copyWith({
    String? comment,
    FoodBlockType? type,
    List<FoodBlockEntity>? foodBlockList,
  }) {
    return PlanBlockEntity(
      comment: comment ?? this.comment,
      type: type ?? this.type,
      foodBlockList: foodBlockList ?? this.foodBlockList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'type': type.name,
      'optionList': foodBlockList.map((x) => x.toMap()).toList(),
    };
  }

  factory PlanBlockEntity.fromMap(Map<String, dynamic> map) {
    return PlanBlockEntity(
      comment: map['comment'] as String,
      type: EnumUtils.stringToEnum(FoodBlockType.values, map['type']) ??
          FoodBlockType.breakFast,
      foodBlockList: List<FoodBlockEntity>.from(
        (map['options']).map<FoodBlockEntity>(
          (x) => FoodBlockEntity.fromMap(Map<String, dynamic>.from(x)),
        ),
      ),
    );
  }

  @override
  List<Object> get props => [comment, type, foodBlockList];
}

enum FoodBlockType { breakFast, brunch, lunch, snack, dinner }

extension FoodBlockTypeExtensions on FoodBlockType {
  String get title {
    switch (this) {
      case FoodBlockType.breakFast:
        return 'Desayuno';
      case FoodBlockType.brunch:
        return 'Almuerzo';
      case FoodBlockType.lunch:
        return 'Comida';
      case FoodBlockType.snack:
        return 'Merienda';
      case FoodBlockType.dinner:
        return 'Cena';
    }
  }
}
