import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_chart_element_entity.dart';

class MeasureChartDataEntity extends Equatable {
  final String imageUrl;
  final String key;
  final String measure;
  final String text;
  final List<MeasureChartElementEntity> elementList;

  const MeasureChartDataEntity({
    required this.imageUrl,
    required this.key,
    required this.measure,
    required this.text,
    required this.elementList,
  });

  int get minElementValue {
    final initialValue = elementList.first.value;
    return elementList.fold(
        initialValue, (min, e) => e.value > min ? min : e.value);
  }

  int get maxElementValue {
    final initialValue = elementList.first.value;
    return elementList.fold(
      initialValue,
      (max, e) => e.value >= max ? e.value : max,
    );
  }

  MeasureChartDataEntity copyWith({
    String? imageUrl,
    String? key,
    String? measure,
    String? text,
    List<MeasureChartElementEntity>? elementList,
  }) {
    return MeasureChartDataEntity(
      imageUrl: imageUrl ?? this.imageUrl,
      key: key ?? this.key,
      measure: measure ?? this.measure,
      text: text ?? this.text,
      elementList: elementList ?? this.elementList,
    );
  }

  @override
  List<Object> get props {
    return [
      imageUrl,
      key,
      measure,
      text,
      elementList,
    ];
  }
}
