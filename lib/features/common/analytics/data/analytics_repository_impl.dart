import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/core/extensions/packages/device_info_plugin.dart';
import 'package:healthy_app/features/common/analytics/domain/repositories/analytics_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final FirebaseAnalytics _analytics;
  final PackageInfo _packageInfo;
  final FirebaseAuth _auth;
  final DeviceInfoPlugin _deviceInfo;

  AnalyticsRepositoryImpl(
    this._analytics,
    this._packageInfo,
    this._auth,
    this._deviceInfo,
  );

  @override
  Future<void> setDefaultEventParameters() async {
    final deviceInfo = await _deviceInfo.deviceInfo;

    final deviceMapInfo = Platform.isAndroid
        ? (deviceInfo as AndroidDeviceInfo).toMapInfo()
        : (deviceInfo as IosDeviceInfo).toMapInfo();

    await _analytics.setDefaultEventParameters({
      'version': _packageInfo.version,
      'buildNumber': _packageInfo.buildNumber,
      'isAndroid': Platform.isAndroid.toString(),
      'email': _auth.currentUser?.email ?? '',
      ...deviceMapInfo,
    });
  }

  @override
  Future<void> logEvent(
    String eventName,
    Map<String, dynamic> parameters,
  ) async {
    await _analytics.logEvent(name: eventName, parameters: parameters);
  }
}
