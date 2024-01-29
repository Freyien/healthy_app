import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/di/config/remote_config.dart';
import 'package:healthy_app/features/client/water_reminder/data/water_reminder_repository_impl.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/client/water_reminder/domain/usecases/show_water_notification_usecase.dart';
import 'package:healthy_app/features/common/notifications/data/notification_repository_impl.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

GetIt slBT = GetIt.instance;

Future<void> diBackgroundTaskInit() async {
  _registerUtilities();

  await _registerLocal();

  await _registerNetwork();

  _registerRepositories();

  _registerBlocs();

  _registerUseCases();
}

// Utilities
void _registerUtilities() {}

// Local
Future<void> _registerLocal() async {
  final _prefs = await SharedPreferences.getInstance();
  slBT.registerLazySingleton<SharedPreferences>(() => _prefs);
}

// Network
Future<void> _registerNetwork() async {
  await RemoteConfig.init();

  slBT.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  slBT.registerLazySingleton<FirebaseCrashlytics>(
    () => FirebaseCrashlytics.instance,
  );
  slBT.registerLazySingleton<FirebaseRemoteConfig>(
    () => FirebaseRemoteConfig.instance,
  );
  slBT.registerLazySingleton<FirebaseFunctions>(
      () => FirebaseFunctions.instance);

  slBT.registerLazySingleton<CloudClient>(
    () => CloudClient(slBT(), slBT(), slBT(), slBT()),
  );
  slBT.registerLazySingleton<AwesomeNotifications>(
      () => AwesomeNotifications());
  slBT.registerLazySingleton<AwesomeNotificationsFcm>(
    () => AwesomeNotificationsFcm(),
  );
  slBT.registerLazySingleton<Workmanager>(
    () => Workmanager(),
  );
}

// Repositories
void _registerRepositories() {
  slBT.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(slBT(), slBT(), slBT(), slBT()),
  );
  slBT.registerLazySingleton<WaterReminderRepository>(
    () => WaterReminderRepositoryImpl(slBT(), slBT()),
  );
}

// Blocs
void _registerBlocs() {}

// Use cases
void _registerUseCases() {
  slBT.registerLazySingleton(
      () => ShowWaterNotificationUsecase(slBT(), slBT()));
}
