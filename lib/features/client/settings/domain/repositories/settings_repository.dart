import 'package:healthy_app/core/domain/entities/response.dart';

abstract class SettingsRepository {
  Response<String> fetchAppVersion();
}
