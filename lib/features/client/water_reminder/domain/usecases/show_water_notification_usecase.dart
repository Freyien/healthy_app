import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

class ShowWaterNotificationUsecase {
  final NotificationRepository _notificationRepository;
  final WaterReminderRepository _waterReminderRepository;

  ShowWaterNotificationUsecase(
    this._notificationRepository,
    this._waterReminderRepository,
  );

  Future<bool> call() async {
    // Get random water notification
    final notificationResponse =
        await _waterReminderRepository.getWaterNotification();

    if (notificationResponse.isFailed) return false;

    // Schedule notification
    final scheduleResponse = await _notificationRepository.showNotification(
      notification: notificationResponse.data!,
    );

    return scheduleResponse.isSuccess;
  }
}
