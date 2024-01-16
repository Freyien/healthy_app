import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_entity.dart';

class MeasureConsultationEntity extends Equatable {
  final String id;
  final DateTime date;
  final List<MeasureEntity> measureList;
  const MeasureConsultationEntity({
    required this.id,
    required this.date,
    required this.measureList,
  });

  MeasureConsultationEntity copyWith({
    String? id,
    DateTime? date,
    List<MeasureEntity>? measureList,
  }) {
    return MeasureConsultationEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      measureList: measureList ?? this.measureList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'measureList': measureList.map((x) => x.toMap()).toList(),
    };
  }

  factory MeasureConsultationEntity.fromMap(Map<String, dynamic> map) {
    return MeasureConsultationEntity(
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] * 1000),
      measureList: List<MeasureEntity>.from(
        (map['measureList']).map<MeasureEntity>(
          (x) => MeasureEntity.fromMap(Map<String, dynamic>.from(x)),
        ),
      ),
    );
  }

  @override
  List<Object> get props => [id, date, measureList];
}
