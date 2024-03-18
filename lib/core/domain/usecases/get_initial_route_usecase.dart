import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/features/common/app_update/domain/repositories/app_update_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:healthy_app/features/common/splash/domain/repositories/splash_repository.dart';

class GetInitialRouteUseCase {
  GetInitialRouteUseCase(
    this._splashRepository,
    this._notificationRepository,
    this._appUpdateRepository,
  );

  final SplashRepository _splashRepository;
  final NotificationRepository _notificationRepository;
  final AppUpdateRepository _appUpdateRepository;

  Future<InitialRouteEntity> call({
    bool checkNotifications = true,
    bool checkUpdateVersion = true,
  }) async {
    await _splashRepository.trackingTransparencyRequest();

    // Notifications
    if (checkNotifications) {
      final notificationRoute = await _checkNotificationPermission();
      if (notificationRoute.isValid) return notificationRoute;
    }

    // Update version
    if (checkUpdateVersion) {
      final updateRoute = await _checkUpdateIsRequired();
      if (updateRoute.isValid) return updateRoute;
    }

    // User is logged In
    final loggedRoute = await _checkUserIsLoggedIn();
    if (loggedRoute.isValid) return loggedRoute;

    // Onboarding completed
    final onboardingRoute = await _checkOnboardingCompleted();
    return onboardingRoute;
  }

  Future<InitialRouteEntity> _checkNotificationPermission() async {
    final res = await _notificationRepository.checkNotificationPermission();

    if (res.isFailed) return InitialRouteEntity();

    switch (res.data!) {
      case NotificationPermissionStatus.denied:
      case NotificationPermissionStatus.unknow:
        return InitialRouteEntity(name: InitialRoute.notification);
      case NotificationPermissionStatus.granted:
      case NotificationPermissionStatus.permanentlyDenied:
        return InitialRouteEntity();
    }
  }

  Future<InitialRouteEntity> _checkUpdateIsRequired() async {
    final response = await _appUpdateRepository.getAppVersionStatus();

    if (response.isFailed) return InitialRouteEntity();

    final appVersionStatus = response.data!;
    if (appVersionStatus.updateIsNotRequired) return InitialRouteEntity();

    return InitialRouteEntity(
      name: InitialRoute.appUpdate,
      params: {
        'appVersionStatus': appVersionStatus,
      },
    );
  }

  Future<InitialRouteEntity> _checkUserIsLoggedIn() async {
    final response = await _splashRepository.isUserloggedIn();
    if (response.isFailed) return InitialRouteEntity(name: InitialRoute.signIn);

    final isUserloggedIn = response.data!;
    if (!isUserloggedIn) return InitialRouteEntity(name: InitialRoute.signIn);

    return InitialRouteEntity();
  }

  Future<InitialRouteEntity> _checkOnboardingCompleted() async {
    final response = await _splashRepository.isOnboardingCompleted();
    if (response.isFailed)
      return InitialRouteEntity(name: InitialRoute.initialConfig);

    final isOnboardingCompleted = response.data!;
    if (!isOnboardingCompleted)
      return InitialRouteEntity(name: InitialRoute.initialConfig);

    return InitialRouteEntity(name: InitialRoute.home);
  }
}
