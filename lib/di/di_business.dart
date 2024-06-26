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
import 'package:healthy_app/features/client/delete_account/data/delete_account_repository_impl.dart';
import 'package:healthy_app/features/client/delete_account/domain/repositories/delete_account_repository.dart';
import 'package:healthy_app/features/client/delete_account/ui/bloc/delete_account_bloc.dart';
import 'package:healthy_app/features/client/doctor_code/data/doctor_code_repository_impl.dart';
import 'package:healthy_app/features/client/doctor_code/domain/repositories/doctor_code_repository.dart';
import 'package:healthy_app/features/client/doctor_code/ui/bloc/doctor_code_bloc.dart';
import 'package:healthy_app/features/client/eating_plan/data/datasource/eating_plan_firebase_datasource.dart';
import 'package:healthy_app/features/client/eating_plan/data/datasource/eating_plan_server_datasource.dart';
import 'package:healthy_app/features/client/eating_plan/data/eating_plan_repository_impl.dart';
import 'package:healthy_app/features/client/eating_plan/domain/repositories/eating_plan_repository.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';
import 'package:healthy_app/features/client/initial_config/data/datasource/initial_config_firebase_datasource.dart';
import 'package:healthy_app/features/client/initial_config/data/datasource/initial_config_server_datasource.dart';
import 'package:healthy_app/features/client/initial_config/data/initial_config_repository_impl.dart';
import 'package:healthy_app/features/client/initial_config/domain/repositories/initial_config_repository.dart';
import 'package:healthy_app/features/client/initial_config/ui/bloc/initial_config_bloc.dart';
import 'package:healthy_app/features/client/measures_chart/data/datasource/measure_chart_firebase_datasource.dart';
import 'package:healthy_app/features/client/measures_chart/data/measure_repository_impl.dart';
import 'package:healthy_app/features/client/measures_chart/domain/repositories/measure_repository.dart';
import 'package:healthy_app/features/client/measures_chart/ui/bloc/measure_bloc.dart';
import 'package:healthy_app/features/client/personal_info/data/personal_info_repository_impl.dart';
import 'package:healthy_app/features/client/personal_info/domain/repositories/personal_info_repository.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';
import 'package:healthy_app/features/client/settings/data/appointment_repository_impl.dart';
import 'package:healthy_app/features/client/settings/data/settings_repository_impl.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/appointment_repository.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/settings_repository.dart';
import 'package:healthy_app/features/client/settings/ui/bloc/settings_bloc.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/bloc/appointment_bloc.dart';
import 'package:healthy_app/features/client/sign_in/data/sign_in_repository_impl.dart';
import 'package:healthy_app/features/client/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:healthy_app/features/client/sign_in/ui/bloc/sign_in_bloc.dart';
import 'package:healthy_app/features/client/sign_up/data/sign_up_repository_impl.dart';
import 'package:healthy_app/features/client/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:healthy_app/features/client/sign_up/ui/bloc/sign_up_bloc.dart';
import 'package:healthy_app/features/client/suggestion/data/suggestion_repository_impl.dart';
import 'package:healthy_app/features/client/suggestion/domain/repositories/suggestion_repository.dart';
import 'package:healthy_app/features/client/suggestion/ui/bloc/suggestion_bloc.dart';
import 'package:healthy_app/features/client/verify_email/data/verify_email_repository_impl.dart';
import 'package:healthy_app/features/client/verify_email/domain/repositories/verify_email_repository.dart';
import 'package:healthy_app/features/client/verify_email/ui/bloc/verify_email_bloc.dart';
import 'package:healthy_app/features/client/water_plan/data/datasource/water_plan_firebase_datasource.dart';
import 'package:healthy_app/features/client/water_plan/data/datasource/water_plan_server_datasource.dart';
import 'package:healthy_app/features/client/water_plan/data/water_plan_repository_impl.dart';
import 'package:healthy_app/features/client/water_plan/domain/repositories/water_plan_repository.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';
import 'package:healthy_app/features/client/water_reminder/data/datasource/water_reminder_firebase_datasource.dart';
import 'package:healthy_app/features/client/water_reminder/data/datasource/water_reminder_server_datasource.dart';
import 'package:healthy_app/features/client/water_reminder/data/water_reminder_repository_impl.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/client/water_reminder/ui/bloc/water_reminder_bloc.dart';
import 'package:healthy_app/features/common/analytics/data/analytics_repository_impl.dart';
import 'package:healthy_app/features/common/analytics/domain/repositories/analytics_repository.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/app_update/data/app_update_repository_impl.dart';
import 'package:healthy_app/features/common/app_update/domain/repositories/app_update_repository.dart';
import 'package:healthy_app/features/common/forgot_password/data/forgot_password_repository_impl.dart';
import 'package:healthy_app/features/common/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:healthy_app/features/common/forgot_password/ui/bloc/forgot_password_bloc.dart';
import 'package:healthy_app/features/common/notifications/data/notification_repository_impl.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/usecases/show_background_notification_usecase.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';
import 'package:healthy_app/features/common/rate/data/rate_repository_impl.dart';
import 'package:healthy_app/features/common/rate/domain/repositories/rate_repository.dart';
import 'package:healthy_app/features/common/rate/ui/bloc/rate_bloc.dart';
import 'package:healthy_app/features/common/reset_password/ui/bloc/reset_password_bloc.dart';
import 'package:healthy_app/features/common/splash/data/splash_repository_impl.dart';
import 'package:healthy_app/features/common/splash/domain/repositories/splash_repository.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;
bool isDIInitialized = false;

Future<void> diBusinessInit() async {
  sl.allowReassignment = true;

  _registerUtilities();

  await _registerLocal();

  await _registerNetwork();

  _registerDatasources();

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

  sl.registerLazySingleton<InAppReview>(
    () => InAppReview.instance,
  );
}

// Datasources
void _registerDatasources() {
  sl.registerLazySingleton<InitialConfigFirebaseDatasource>(
    () => InitialConfigFirebaseDatasource(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<InitialConfigServerDatasource>(
    () => InitialConfigServerDatasource(sl()),
  );

  sl.registerLazySingleton<EatingPlanFirebaseDatasource>(
    () => EatingPlanFirebaseDatasource(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<EatingPlanServerDatasource>(
    () => EatingPlanServerDatasource(sl()),
  );

  sl.registerLazySingleton<WaterPlanFirebaseDatasource>(
    () => WaterPlanFirebaseDatasource(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<WaterPlanServerDatasource>(
    () => WaterPlanServerDatasource(sl()),
  );

  sl.registerLazySingleton<MeasureChartFirebaseDatasource>(
    () => MeasureChartFirebaseDatasource(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<WaterReminderFirebaseDatasource>(
    () => WaterReminderFirebaseDatasource(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<WaterReminderServerDatasource>(
    () => WaterReminderServerDatasource(sl()),
  );
}

// Repositories
void _registerRepositories() {
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(sl(), sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<AppUpdateRepository>(
    () => AppUpdateRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(sl(), sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<DoctorCodeRepository>(
    () => DoctorCodeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<InitialConfigRepository>(
    () => InitialConfigRepositoryImpl(sl(), sl(), sl(), sl()),
  );
  sl.registerLazySingleton<PersonalInfoRepository>(
    () => PersonalInfoRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<EatingPlanRepository>(
    () => EatingPlanRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<WaterPlanRepository>(
    () => WaterPlanRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<MeasureRepository>(
    () => MeasureRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<SuggestionRepository>(
    () => SuggestionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<WaterReminderRepository>(
    () => WaterReminderRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<DeleteAccountRepository>(
    () => DeleteAccountRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<VerifyEmailRepository>(
    () => VerifyEmailRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<RateRepository>(
    () => RateRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(sl(), sl(), sl()),
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
  sl.registerFactory(() => EatingPlanBloc(sl()));
  sl.registerFactory(() => WaterPlanBloc(sl(), sl()));
  sl.registerFactory(() => MeasureBloc(sl()));
  sl.registerFactory(() => SettingsBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SuggestionBloc(sl()));
  sl.registerFactory(() => WaterReminderBloc(sl()));
  sl.registerFactory(() => DeleteAccountBloc(sl(), sl()));
  sl.registerFactory(() => VerifyEmailBloc(sl()));
  sl.registerFactory(() => RateBloc(sl()));
  sl.registerFactory(() => ForgotPasswordBloc(sl()));
  sl.registerFactory(() => ResetPasswordBloc(sl()));
  sl.registerFactory(() => AppointmentBloc(sl()));
}

// Use cases
void _registerUseCases() {
  sl.registerLazySingleton(() => GetInitialRouteUseCase(sl(), sl(), sl()));
  sl.registerLazySingleton(() => ShowBackgroundNotificationUseCase(sl()));
}
