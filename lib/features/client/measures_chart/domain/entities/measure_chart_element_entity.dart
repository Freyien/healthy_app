import 'package:equatable/equatable.dart';

class MeasureChartElementEntity extends Equatable {
  final int value;
  final DateTime date;

  const MeasureChartElementEntity({
    required this.value,
    required this.date,
  });

  MeasureChartElementEntity copyWith({
    int? value,
    DateTime? date,
  }) {
    return MeasureChartElementEntity(
      value: value ?? this.value,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [value, date];
}
