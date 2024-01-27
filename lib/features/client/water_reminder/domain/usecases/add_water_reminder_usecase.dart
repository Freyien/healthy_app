import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

class AddWaterReminderUsecase {
  final NotificationRepository _notificationRepository;
  final WaterReminderRepository _waterReminderRepository;

  AddWaterReminderUsecase(
    this._notificationRepository,
    this._waterReminderRepository,
  );

  Future<Response<void>> call(DateTime scheduledDate) async {
    // Get pending notifications
    final pendingNotificationResponse =
        await _notificationRepository.checkPendingNotification();

    if (pendingNotificationResponse.isFailed)
      return pendingNotificationResponse;

    // Get random water notification
    final notificationResponse =
        await _waterReminderRepository.getWaterNotification();

    if (notificationResponse.isFailed) return notificationResponse;

    // Schedule notification
    final scheduleResponse = await _notificationRepository.scheduleNotification(
      notificationResponse.data!,
      scheduledDate,
    );

    if (scheduleResponse.isFailed) return scheduleResponse;

    // Cancel pending notifications
    pendingNotificationResponse.data!.forEach((notification) async {
      if (notification.type != NotificationType.waterReminder) return;

      await _notificationRepository.cancelNotification(notification.id);
    });

    return Response.success(null);
  }
}
