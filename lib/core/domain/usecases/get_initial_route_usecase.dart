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

    return InitialRouteEntity(name: InitialRoute.signIn);
  }

  Future<InitialRouteEntity> _checkNotificationPermission() async {
    final res = await _notificationRepository.requestPermission();

    if (res.isFailed) return InitialRouteEntity();

    final permissionStatus = res.data!;

    switch (permissionStatus.status) {
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
    if (response.isFailed) return InitialRouteEntity();

    final isUserloggedIn = response.data!;
    if (!isUserloggedIn) return InitialRouteEntity(name: InitialRoute.signIn);

    return InitialRouteEntity(name: InitialRoute.initialConfig);
  }
}
