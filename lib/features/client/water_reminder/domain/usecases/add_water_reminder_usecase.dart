import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

class AddWaterReminderUsecase {
  final NotificationRepository _notificationRepository;
  final WaterReminderRepository _waterReminderRepository;

  AddWaterReminderUsecase(
    this._notificationRepository,
    this._waterReminderRepository,
  );

  Future<Response<void>> call(int interval) async {
    // Get random water notification
    final notificationResponse =
        await _waterReminderRepository.getWaterNotification();

    if (notificationResponse.isFailed) return notificationResponse;

    // Cancel pending notifications
    final channel = HealthyConstants.waterReminderChannel;
    await _notificationRepository.cancelSchedulesByChannelKey(channel);

    // Schedule notification
    final scheduleResponse = await _notificationRepository.scheduleNotification(
      channelKey: channel,
      interval: interval,
      notification: notificationResponse.data!,
      repeats: true,
    );

    if (scheduleResponse.isFailed) return scheduleResponse;

    return Response.success(null);
  }
}
