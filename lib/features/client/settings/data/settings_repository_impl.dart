import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final PackageInfo _packageInfo;

  SettingsRepositoryImpl(this._packageInfo);

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
