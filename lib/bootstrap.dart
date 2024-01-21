import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/domain/usecases/get_initial_route_usecase.dart';
import 'package:healthy_app/di/di_background_notifications.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/notifications/domain/usecases/show_background_notification_usecase.dart';
import 'package:healthy_app/firebase/firebase_options.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function(InitialRouteEntity) builder,
) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Init Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );

    // Report Error
    _reportError();

    // Dependency injection
    await diBusinessInit();

    // Bloc observer
    Bloc.observer = const AppBlocObserver();
  } catch (_) {}

  // Get initial route
  final initialRoute = await sl<GetInitialRouteUseCase>().call();

  runApp(await builder(initialRoute));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) return;

  /* From background */
  if (isDIInitialized) {
    await sl<ShowBackgroundNotificationUseCase>().handleMessage(message);
    return;
  }

  /* From terminated */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await diBackgroundNotifications();

  await slb<ShowBackgroundNotificationUseCase>().initLocalNotifications();
  await slb<ShowBackgroundNotificationUseCase>().handleMessage(message);
}

Future<void> _reportError() async {
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
