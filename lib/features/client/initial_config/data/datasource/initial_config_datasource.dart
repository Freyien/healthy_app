import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';

abstract class InitialConfigDatasource {
  Future<InitialConfigEntity?> getInitialConfig();
  Future<void> addInitialConfig();
}
