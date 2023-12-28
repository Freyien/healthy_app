import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/personal_info/domain/entities/personal_info_entity.dart';
import 'package:healthy_app/features/client/personal_info/domain/repositories/personal_info_repository.dart';

class PersonalInfoRepositoryImpl implements PersonalInfoRepository {
  final CloudClient _client;

  PersonalInfoRepositoryImpl(this._client);

  @override
  Future<Response<void>> savePersonalInfo(
    PersonalInfoEntity personalInfo,
  ) async {
    try {
      final params = personalInfo.toMap();
      await _client.post('savePersonalInfo', parameters: params);

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
