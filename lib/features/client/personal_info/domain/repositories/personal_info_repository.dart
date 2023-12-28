import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/personal_info/domain/entities/personal_info_entity.dart';

abstract class PersonalInfoRepository {
  Future<Response<void>> savePersonalInfo(PersonalInfoEntity personalInfo);
}
