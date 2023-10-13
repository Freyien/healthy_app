import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/usecases/get_initial_route_usecase.dart';
import 'package:healthy_app/core/ui/constants/app_colors.dart';
import 'package:healthy_app/di/config/remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;
bool isDIInitialized = false;

Future<void> diBusinessInit() async {
  _registerUtilities();

  await _registerLocal();

  await _registerNetwork();

  _registerRepositories();

  _registerBlocs();

  _registerUseCases();

  isDIInitialized = true;
}

// Utilities
void _registerUtilities() {
  sl.registerLazySingleton<DefaultColors>(() => DefaultColors());
}

// Local
Future<void> _registerLocal() async {
  final _prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => _prefs);
}

// Network
Future<void> _registerNetwork() async {
  await RemoteConfig.init();

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseCrashlytics>(
    () => FirebaseCrashlytics.instance,
  );
  sl.registerLazySingleton<FirebaseFunctions>(() => FirebaseFunctions.instance);
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
  sl.registerLazySingleton<FirebaseRemoteConfig>(
    () => FirebaseRemoteConfig.instance,
  );
  sl.registerLazySingleton<FirebaseAnalytics>(
    () => FirebaseAnalytics.instance,
  );

  final packageInfo = await PackageInfo.fromPlatform();
  sl.registerLazySingleton<PackageInfo>(() => packageInfo);

  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<CloudClient>(
    () => CloudClient(sl(), sl(), sl(), sl()),
  );
}

// Repositories
void _registerRepositories() {}

// Blocs
void _registerBlocs() {}

// Use cases
void _registerUseCases() {
  sl.registerLazySingleton(() => GetInitialRouteUseCase(sl(), sl(), sl()));
  // sl.registerLazySingleton(() => ShowBackgroundNotificationUseCase(sl()));
}
