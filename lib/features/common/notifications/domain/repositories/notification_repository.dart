import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  // Permissions
  Future<Response<bool>> checkNotificationPermission();
  Future<Response<void>> openNotificationSettings();
  Future<Response<bool>> requestPermission();

  // Config
  Future<void> initRemoteNotifications();
  Future<void> initLocalNotifications();

  // Token
  Future<void> savetoken();

  Future<Response<NotificationEntity?>> getInitialMessage();
  Stream<NotificationEntity?> onActionReceivedMethod();

  // Topics
  Future<void> suscribeToCommonTipics();
  Future<void> unsuscribeToCommonTipics();

  // Schedule
  Future<Response<void>> scheduleNotification({
    required NotificationEntity notification,
    required String channelKey,
    required int interval,
    bool repeats = true,
  });
  Future<Response<void>> cancelSchedulesByChannelKey(String channelKey);
}
