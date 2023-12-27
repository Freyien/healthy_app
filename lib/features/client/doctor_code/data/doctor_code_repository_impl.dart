import 'package:cloud_functions/cloud_functions.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/doctor_code/domain/failures/doctor_code_failures.dart';
import 'package:healthy_app/features/client/doctor_code/domain/repositories/doctor_code_repository.dart';

class DoctorCodeRepositoryImpl implements DoctorCodeRepository {
  final CloudClient _client;

  DoctorCodeRepositoryImpl(this._client);

  @override
  Future<Response<void>> saveDoctorCode(String code) async {
    try {
      await _client.post('doctorAssign', parameters: {
        'code': code,
      });

      return Response.success(null);
    } on FirebaseFunctionsException catch (e) {
      final errorCode = e.details['errorCode'] ?? '';
      if (errorCode == 'doctorDoesNotExists')
        return Response.failed(DoctorDoesNotExistsFailure());

      throw e;
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
