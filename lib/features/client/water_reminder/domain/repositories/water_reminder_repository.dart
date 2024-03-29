import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';

abstract class WaterReminderRepository {
  Future<Response<WaterReminderEntity>> getWaterReminder();
  Future<Response<void>> saveWaterReminder(
    WaterReminderEntity waterReminder,
  );
}
