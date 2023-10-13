import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';
import 'package:healthy_app/features/common/app_update/domain/repositories/app_update_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdateRepositoryImpl implements AppUpdateRepository {
  final PackageInfo _packageInfo;
  final FirebaseRemoteConfig _remoteConfig;

  AppUpdateRepositoryImpl(this._packageInfo, this._remoteConfig);

  @override
  Future<Response<AppVersionStatus>> getAppVersionStatus() async {
    try {
      final source = _remoteConfig.getString('appVersionStatus');

      final appVersionStatus = AppVersionStatus.fromJson(source).copyWith(
        currentVersion: int.tryParse(_packageInfo.buildNumber) ?? 0,
      );

      return Response.success(appVersionStatus);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
