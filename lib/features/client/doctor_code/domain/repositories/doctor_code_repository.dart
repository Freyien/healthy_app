import 'package:healthy_app/core/domain/entities/response.dart';

abstract class DoctorCodeRepository {
  Future<Response<void>> saveDoctorCode(String code);
}
