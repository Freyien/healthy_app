import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';

abstract class NotificationRepository {
  // Permissions
  Future<Response<PermissionStatusEntity>> checkNotificationPermission();
  Future<Response<void>> openNotificationSettings();
  Future<Response<PermissionStatusEntity>> requestPermission();

  // Config
  Future<void> initRemoteNotifications();
  Future<void> initLocalNotifications();

  // Token
  Future<void> savetoken();

  // Notifications
  Future<Response<NotificationEntity?>> getInitialMessage();
  Stream<NotificationEntity?> onActionReceivedMethod();
  Future<Response<void>> showNotification({
    required NotificationEntity notification,
  });

  // Topics
  Future<void> suscribeToCommonTipics();
  Future<void> unsuscribeToCommonTipics();
}
