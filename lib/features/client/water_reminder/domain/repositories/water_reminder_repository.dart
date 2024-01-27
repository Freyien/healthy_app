import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';

abstract class WaterReminderRepository {
  Future<Response<WaterReminderEntity>> getWaterReminder();
  Future<Response<WaterConsumptionEntity>> saveWaterReminder(
    WaterReminderEntity waterReminder,
  );

  Future<Response<NotificationEntity>> getWaterNotification();
}
