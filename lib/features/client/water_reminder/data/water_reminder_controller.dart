import 'package:firebase_core/firebase_core.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/di/di_background_taks.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/client/water_reminder/domain/usecases/show_water_notification_usecase.dart';
import 'package:healthy_app/firebase/firebase_options.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await diBackgroundTaskInit();

    if (task == HealthyConstants.waterReminderChannel) {
      await _waterReminder(inputData!);
    }

    return Future.value(true);
  });
}

Future<void> _waterReminder(Map<String, dynamic> inputData) async {
  final waterReminder = WaterReminderEntity.fromMap(
    inputData,
    fromTimestamp: false,
  );

  try {
    await slBT<ShowWaterNotificationUsecase>().call();

    await slBT<WaterReminderRepository>().addLocalWaterReminder(
      waterReminder,
      replaceIfExists: false,
    );
  } catch (e) {
    await slBT<WaterReminderRepository>().addLocalWaterReminder(waterReminder);
  }
}
