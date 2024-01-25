import 'package:equatable/equatable.dart';

class WaterConsumptionEntity extends Equatable {
  final String id;
  final int quantity;
  final DateTime date;
  final bool animate;

  const WaterConsumptionEntity({
    required this.id,
    required this.quantity,
    required this.date,
    required this.animate,
  });

  WaterConsumptionEntity copyWith({
    String? id,
    int? quantity,
    DateTime? date,
    bool? animate,
  }) {
    return WaterConsumptionEntity(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      animate: animate ?? this.animate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory WaterConsumptionEntity.fromMap(Map<String, dynamic> map) {
    return WaterConsumptionEntity(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] * 1000),
      animate: true,
    );
  }

  @override
  List<Object> get props => [id, quantity, date, animate];
}
