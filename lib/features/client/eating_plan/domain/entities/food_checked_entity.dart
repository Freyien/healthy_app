import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FoodCheckedEntity extends Equatable {
  final String id;
  final DateTime date;
  final Map<String, bool> checked;
  const FoodCheckedEntity({
    required this.id,
    required this.date,
    required this.checked,
  });

  factory FoodCheckedEntity.initial() => FoodCheckedEntity(
        id: '',
        date: DateTime.now(),
        checked: {},
      );

  FoodCheckedEntity copyWith({
    String? id,
    DateTime? date,
    Map<String, bool>? checked,
  }) {
    return FoodCheckedEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'checked': checked,
    };
  }

  factory FoodCheckedEntity.fromMap(Map<String, dynamic> map) {
    final date = map['date'] is Timestamp
        ? (map['date'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(map['date'] * 1000);

    return FoodCheckedEntity(
      id: map['id'] as String,
      date: date,
      checked: Map<String, bool>.from(map['foodChecked']),
    );
  }

  @override
  List<Object> get props => [id, date, checked];
}
