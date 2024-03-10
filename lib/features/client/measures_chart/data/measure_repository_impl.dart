import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/measures_chart/data/datasource/measure_chart_firebase_datasource.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';
import 'package:healthy_app/features/client/measures_chart/domain/repositories/measure_repository.dart';

class MeasureRepositoryImpl implements MeasureRepository {
  final MeasureChartFirebaseDatasource _firebase;

  MeasureRepositoryImpl(this._firebase);

  @override
  Future<Response<List<MeasureConsultationEntity>>>
      getMeasureConsultation() async {
    try {
      final measureConsultationList = await _firebase.getMeasureConsultation();

      return Response.success(measureConsultationList);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
