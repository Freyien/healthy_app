import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';

abstract class MeasureRepository {
  Future<Response<List<MeasureConsultationEntity>>> getMeasureConsultation();
}
