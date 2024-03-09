import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/features/client/initial_config/data/datasource/initial_config_datasource.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';

class InitialConfigServerDatasource implements InitialConfigDatasource {
  final CloudClient _client;

  InitialConfigServerDatasource(this._client);

  @override
  Future<InitialConfigEntity?> getInitialConfig() async {
    final result = await _client.get('getInitialConfig', useCache: false);

    final initialConfig = InitialConfigEntity.fromMap(result);

    return initialConfig;
  }

  @override
  Future<void> addInitialConfig() async {
    await _client.post('addInitialConfig');
  }
}
