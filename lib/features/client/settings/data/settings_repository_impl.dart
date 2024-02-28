import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/settings/domain/entities/client_entity.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final PackageInfo _packageInfo;
  final CloudClient _client;

  SettingsRepositoryImpl(this._packageInfo, this._client);

  @override
  Future<Response<ClientEntity>> getClient() async {
    try {
      final result = await _client.get(
        'getClientByAccount',
        useCache: true,
      );

      final client = ClientEntity.fromMap(result);

      return Response.success(client);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Response<String> fetchAppVersion() {
    try {
      final appVersion = _packageInfo.version;

      return Response.success(appVersion);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
