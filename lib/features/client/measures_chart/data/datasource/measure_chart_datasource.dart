import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';

abstract class MeasureChartDatasource {
  Future<List<MeasureConsultationEntity>> getMeasureConsultation();
}
