import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

class ShowBackgroundNotificationUseCase {
  final NotificationRepository _repository;

  ShowBackgroundNotificationUseCase(this._repository);

  Future<void> initLocalNotifications() async {
    await _repository.initLocalNotifications();
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = NotificationEntity.fromRemoteMessage(message);
    await _repository.showNotification(notification);
  }
}
