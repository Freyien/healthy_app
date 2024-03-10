import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/features/client/water_reminder/data/datasource/water_reminder_datasource.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';

class WaterReminderServerDatasource implements WaterReminderDatasource {
  final CloudClient _client;

  WaterReminderServerDatasource(this._client);

  @override
  Future<WaterReminderEntity> getWaterReminder() async {
    final result = await _client.get(
      'getWaterReminder',
      useCache: false,
    );

    final waterReminder = WaterReminderEntity.fromMap(result);
    return waterReminder;
  }

  @override
  Future<void> saveWaterReminder(WaterReminderEntity waterReminder) async {
    await _client.post(
      'saveWaterReminder',
      parameters: waterReminder.toMap(),
    );
  }
}
