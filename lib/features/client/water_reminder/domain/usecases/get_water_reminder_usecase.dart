import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';

class GetWaterReminderDateUsecase {
  final WaterReminderRepository _waterReminderRepository;

  GetWaterReminderDateUsecase(this._waterReminderRepository);

  Future<int> call(DateTime lastEventDate) async {
    final reminderResponse = await _waterReminderRepository.getWaterReminder();

    if (reminderResponse.isFailed)
      return HealthyConstants.reminderSecondsInterval;

    final waterReminder = reminderResponse.data!;
    return waterReminder.intervalToSeconds;
  }
}
