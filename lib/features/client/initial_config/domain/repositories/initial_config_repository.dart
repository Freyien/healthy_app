import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';

abstract class InitialConfigRepository {
  Future<Response<bool>> checkEmailVerified();
  Future<Response<InitialConfigEntity>> getInitialConfig();
}
