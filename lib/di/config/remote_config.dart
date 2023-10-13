import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  static Future<FirebaseRemoteConfig> init() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 2),
        minimumFetchInterval: const Duration(seconds: 1),
      ));

      await remoteConfig.fetch();
      await remoteConfig.activate();
      // await Future.delayed(const Duration(seconds: 1));
      // await remoteConfig.fetchAndActivate();

      return remoteConfig;
    } catch (e) {
      return FirebaseRemoteConfig.instance;
    }
  }
}
