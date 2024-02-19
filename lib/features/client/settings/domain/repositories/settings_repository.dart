import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/settings/domain/entities/client_entity.dart';

abstract class SettingsRepository {
  Future<Response<ClientEntity>> getClient();
  Response<String> fetchAppVersion();
}
