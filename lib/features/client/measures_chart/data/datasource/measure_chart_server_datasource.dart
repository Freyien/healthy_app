import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/features/client/measures_chart/data/datasource/measure_chart_datasource.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';

class MeasureChartServerDatasource implements MeasureChartDatasource {
  final CloudClient _client;

  MeasureChartServerDatasource(this._client);

  @override
  Future<List<MeasureConsultationEntity>> getMeasureConsultation() async {
    final result = await _client.get(
      'getClientMeasureList',
      useCache: false,
    );

    final measureConsultationList = List<MeasureConsultationEntity>.from(
      result.map(
        (item) {
          final measureConsultation = Map<String, dynamic>.from(item);
          return MeasureConsultationEntity.fromMap(measureConsultation);
        },
      ),
    );

    return measureConsultationList;
  }
}
