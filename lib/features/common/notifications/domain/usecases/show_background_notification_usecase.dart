import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

class ShowBackgroundNotificationUseCase {
  final NotificationRepository _repository;

  ShowBackgroundNotificationUseCase(this._repository);

  Future<void> initLocalNotifications() async {
    await _repository.initLocalNotifications();
  }

  Future<void> handleMessage(RemoteMessage message) async {
    await _repository.handleMessage(message);
  }
}
