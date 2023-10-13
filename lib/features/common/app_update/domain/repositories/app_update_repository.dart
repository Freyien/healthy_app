import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';

abstract class AppUpdateRepository {
  Future<Response<AppVersionStatus>> getAppVersionStatus();
}
