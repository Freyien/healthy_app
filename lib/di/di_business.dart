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
import 'package:healthy_app/features/client/doctor_code/data/doctor_code_repository_impl.dart';
import 'package:healthy_app/features/client/doctor_code/domain/repositories/doctor_code_repository.dart';
import 'package:healthy_app/features/client/doctor_code/ui/bloc/doctor_code_bloc.dart';
import 'package:healthy_app/features/client/initial_config/data/initial_config_repository_impl.dart';
import 'package:healthy_app/features/client/initial_config/domain/repositories/initial_config_repository.dart';
import 'package:healthy_app/features/client/initial_config/ui/bloc/initial_config_bloc.dart';
import 'package:healthy_app/features/client/personal_info/data/personal_info_repository_impl.dart';
import 'package:healthy_app/features/client/personal_info/domain/repositories/personal_info_repository.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';
import 'package:healthy_app/features/client/sign_in/data/sign_in_repository_impl.dart';
import 'package:healthy_app/features/client/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:healthy_app/features/client/sign_in/ui/bloc/sign_in_bloc.dart';
import 'package:healthy_app/features/client/sign_up/data/sign_up_repository_impl.dart';
import 'package:healthy_app/features/client/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:healthy_app/features/client/sign_up/ui/bloc/sign_up_bloc.dart';
import 'package:healthy_app/features/common/analytics/data/analytics_repository_impl.dart';
import 'package:healthy_app/features/common/analytics/domain/repositories/analytics_repository.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/app_update/data/app_update_repository_impl.dart';
import 'package:healthy_app/features/common/app_update/domain/repositories/app_update_repository.dart';
import 'package:healthy_app/features/common/notifications/data/notification_repository_impl.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/usecases/show_background_notification_usecase.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';
import 'package:healthy_app/features/common/splash/data/splash_repository_impl.dart';
import 'package:healthy_app/features/common/splash/domain/repositories/splash_repository.dart';
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
void _registerRepositories() {
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(sl(), sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AppUpdateRepository>(
    () => AppUpdateRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<DoctorCodeRepository>(
    () => DoctorCodeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<InitialConfigRepository>(
    () => InitialConfigRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PersonalInfoRepository>(
    () => PersonalInfoRepositoryImpl(sl()),
  );
}

// Blocs
void _registerBlocs() {
  sl.registerFactory(() => AnalyticsBloc(sl()));
  sl.registerFactory(() => NotificationBloc(sl(), sl()));
  sl.registerFactory(() => SignInBloc(sl()));
  sl.registerFactory(() => SignUpBloc(sl()));
  sl.registerFactory(() => DoctorCodeBloc(sl()));
  sl.registerFactory(() => InitialConfigBloc(sl()));
  sl.registerFactory(() => PersonalInfoBloc(sl()));
}

// Use cases
void _registerUseCases() {
  sl.registerLazySingleton(() => GetInitialRouteUseCase(sl(), sl(), sl()));
  sl.registerLazySingleton(() => ShowBackgroundNotificationUseCase(sl()));
}
