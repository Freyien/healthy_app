import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_option_entity.dart';

class FoodBlockEntity extends Equatable {
  final String id;
  final List<FoodOptionEntity> optionList;
  final bool checked;

  const FoodBlockEntity({
    required this.id,
    required this.optionList,
    required this.checked,
  });

  FoodBlockEntity copyWith({
    String? id,
    List<FoodOptionEntity>? optionList,
    bool? checked,
  }) {
    return FoodBlockEntity(
      id: id ?? this.id,
      optionList: optionList ?? this.optionList,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'optionList': optionList.map((x) => x.toMap()).toList(),
      'checked': checked,
    };
  }

  factory FoodBlockEntity.fromMap(Map<String, dynamic> map) {
    return FoodBlockEntity(
      id: map['id'],
      optionList: List<FoodOptionEntity>.from(
        (map['foodList']).map<FoodOptionEntity>(
          (x) => FoodOptionEntity.fromMap(Map<String, dynamic>.from(x)),
        ),
      ),
      checked: false,
    );
  }

  @override
  List<Object> get props => [id, optionList, checked];
}
