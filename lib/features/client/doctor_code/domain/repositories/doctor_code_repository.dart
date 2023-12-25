import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/doctor_code/domain/entities/client_entity.dart';

abstract class DoctorCodeRepository {
  Future<Response<ClientEntity>> getClient();
  Future<Response<void>> saveDoctorCode(String code);
}
