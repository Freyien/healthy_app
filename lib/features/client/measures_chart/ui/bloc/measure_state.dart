part of 'measure_bloc.dart';

class MeasureState extends Equatable {
  const MeasureState({
    required this.fetchingStatus,
    required this.measureConsultationList,
  });

  final FetchingStatus fetchingStatus;
  final List<MeasureConsultationEntity> measureConsultationList;

  List<MeasureChartDataEntity> get chartDataList {
    final List<MeasureChartDataEntity> chartData = [];
    final Map<String, MeasureChartDataEntity> result = {};

    measureConsultationList.reversed.forEach((measureConsultation) {
      measureConsultation.measureList.forEach((measure) {
        final keyExists = result[measure.key] != null;

        print(keyExists);

        // Add measure chart data if not exists
        if (!keyExists) {
          result[measure.key] = MeasureChartDataEntity(
            imageUrl: measure.imageUrl,
            key: measure.key,
            measure: measure.measure,
            text: measure.text,
            elementList: [],
          );
        }

        // Add element values
        result[measure.key]!.elementList.add(
              MeasureChartElementEntity(
                value: measure.value,
                date: measureConsultation.date,
              ),
            );
      });
    });

    // Create list
    result.values.forEach((v) => chartData.add(v));

    return chartData;
  }

  factory MeasureState.initial() => MeasureState(
        fetchingStatus: FetchingStatus.initial,
        measureConsultationList: [],
      );

  MeasureState copyWith({
    FetchingStatus? fetchingStatus,
    List<MeasureConsultationEntity>? measureConsultationList,
  }) {
    return MeasureState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      measureConsultationList:
          measureConsultationList ?? this.measureConsultationList,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, measureConsultationList];
}
