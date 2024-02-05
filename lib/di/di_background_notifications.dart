import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:healthy_app/features/common/notifications/data/notification_repository_impl.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/usecases/show_background_notification_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt slb = GetIt.asNewInstance();
bool isDIBInitialized = false;

Future<void> diBackgroundNotifications() async {
  await _registerLocal();

  await _registerNetwork();

  _registerRepositories();

  _registerUseCases();

  isDIBInitialized = true;
}

// Local
Future<void> _registerLocal() async {
  final _prefs = await SharedPreferences.getInstance();
  slb.registerLazySingleton<SharedPreferences>(() => _prefs);
}

// Network
Future<void> _registerNetwork() async {
  slb.registerLazySingleton<FirebaseFunctions>(
    () => FirebaseFunctions.instance,
  );
  slb.registerLazySingleton<FirebaseMessaging>(
    () => FirebaseMessaging.instance,
  );
}

// Repositories
void _registerRepositories() {
  slb.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(slb(), slb(), slb()),
  );
}

// Use cases
void _registerUseCases() {
  slb.registerLazySingleton(() => ShowBackgroundNotificationUseCase(slb()));
}
