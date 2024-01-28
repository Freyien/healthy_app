import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';

class NotificationController {
  static final streamReceivedAction = StreamController<NotificationEntity>();
  static final streamFcmToken = StreamController<String>();

  static final streamReceivedActionController =
      StreamController<NotificationEntity>();

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    final notification = NotificationEntity.fromReceivedAction(
      receivedAction,
    );

    streamReceivedAction.add(notification);
  }

  @pragma('vm:entry-point')
  static Future<void> onFcmTokenHandle(String token) async {
    if (token.isEmpty) return;

    streamFcmToken.add(token);
  }
}
