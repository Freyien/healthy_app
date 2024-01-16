import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';
import 'package:healthy_app/features/client/measures_chart/domain/repositories/measure_repository.dart';

class MeasureRepositoryImpl implements MeasureRepository {
  final CloudClient _client;

  MeasureRepositoryImpl(this._client);

  @override
  Future<Response<List<MeasureConsultationEntity>>>
      getMeasureConsultation() async {
    try {
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

      return Response.success(measureConsultationList);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
