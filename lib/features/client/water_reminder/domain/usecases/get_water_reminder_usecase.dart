import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';

class GetWaterReminderDateUsecase {
  final WaterReminderRepository _waterReminderRepository;

  GetWaterReminderDateUsecase(this._waterReminderRepository);

  Future<DateTime> call(DateTime lastEventDate) async {
    final reminderResponse = await _waterReminderRepository.getWaterReminder();

    if (reminderResponse.isFailed) return DateTime.now();

    final waterReminder = reminderResponse.data!.copyWith(
      lastEventDate: lastEventDate,
    );

    return waterReminder.scheduleDate;
  }
}
