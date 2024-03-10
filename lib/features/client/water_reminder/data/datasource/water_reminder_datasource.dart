import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';

abstract class WaterReminderDatasource {
  Future<WaterReminderEntity> getWaterReminder();
  Future<void> saveWaterReminder(WaterReminderEntity waterReminder);
}
