import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Response<AuthorizationStatus>> checkNotificationPermission();
  Future<Response<void>> openNotificationSettings();
  Stream<NotificationEntity> initForegroundNotifications();
  Future<void> initLocalNotifications();
  Future<Response<AuthorizationStatus>> requestPermission();
  Future<void> savetoken();
  Future<Response<NotificationEntity?>> getInitialMessage();
  Stream<RemoteMessage> onMessageOpenedApp();
  void onMessage();
  Future<void> handleMessage(RemoteMessage message);

  // Topics
  Future<void> suscribeToCommonTipics();
  Future<void> unsuscribeToCommonTipics();

  // Schedule
  Future<Response<void>> scheduleNotification(
    NotificationEntity notification,
    DateTime scheduledDate,
  );
  Future<Response<List<NotificationEntity>>> checkPendingNotification();
  Future<Response<void>> cancelNotification(int id);
}
