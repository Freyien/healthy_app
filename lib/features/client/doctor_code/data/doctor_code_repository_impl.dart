import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/doctor_code/domain/entities/client_entity.dart';
import 'package:healthy_app/features/client/doctor_code/domain/repositories/doctor_code_repository.dart';

class DoctorCodeRepositoryImpl implements DoctorCodeRepository {
  final CloudClient _client;

  DoctorCodeRepositoryImpl(this._client);

  @override
  Future<Response<ClientEntity>> getClient() async {
    try {
      final result = await _client.get('getClientByAuth', useCache: false);

      final client = ClientEntity.fromMap(result);

      return Response.success(client);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> saveDoctorCode(String code) async {
    try {
      await _client.post('doctorAssign', parameters: {
        'code': code,
      });

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
