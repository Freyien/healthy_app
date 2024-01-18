import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';

class WaterPlanEntity extends Equatable {
  final String id;
  final int water;
  final List<WaterConsumptionEntity> waterConsumptionList;

  const WaterPlanEntity({
    required this.id,
    required this.water,
    required this.waterConsumptionList,
  });

  factory WaterPlanEntity.initial() => WaterPlanEntity(
        id: '',
        water: 0,
        waterConsumptionList: [],
      );

  WaterPlanEntity copyWith({
    String? id,
    int? water,
    List<WaterConsumptionEntity>? waterConsumptionList,
  }) {
    return WaterPlanEntity(
      id: id ?? this.id,
      water: water ?? this.water,
      waterConsumptionList: waterConsumptionList ?? this.waterConsumptionList,
    );
  }

  int get totalWaterConsumption {
    return waterConsumptionList.fold(
      0,
      (previousValue, e) => previousValue + e.quantity,
    );
  }

  int get remainingWaterConsumption {
    if (totalWaterConsumption > water) return 0;

    return water - totalWaterConsumption;
  }

  int get totalWaterConsumptionPercent {
    if (totalWaterConsumption == 0) return 0;

    return totalWaterConsumption * 100 ~/ water;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'water': water,
      'waterConsumptionList':
          waterConsumptionList.map((x) => x.toMap()).toList(),
    };
  }

  factory WaterPlanEntity.fromMap(Map<String, dynamic> map) {
    if (map['id'] == null) return WaterPlanEntity.initial();

    return WaterPlanEntity(
      id: map['id'] as String,
      water: ((map['water'] * 1000) as num).toInt(),
      waterConsumptionList: List<WaterConsumptionEntity>.from(
        (map['waterConsumptionList']).map<WaterConsumptionEntity>(
          (x) => WaterConsumptionEntity.fromMap(
            Map<String, dynamic>.from(x),
          ),
        ),
      ),
    );
  }

  @override
  List<Object> get props => [id, water, waterConsumptionList];
}
