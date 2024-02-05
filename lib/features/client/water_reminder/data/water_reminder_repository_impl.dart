import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';

class WaterReminderRepositoryImpl implements WaterReminderRepository {
  final CloudClient _client;

  WaterReminderRepositoryImpl(this._client);

  @override
  Future<Response<WaterReminderEntity>> getWaterReminder() async {
    try {
      final result = await _client.get(
        'getWaterReminder',
        useCache: false,
      );

      final waterReminder = WaterReminderEntity.fromMap(result);

      return Response.success(waterReminder);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> saveWaterReminder(
    WaterReminderEntity waterReminder,
  ) async {
    try {
      await _client.post(
        'saveWaterReminder',
        parameters: waterReminder.toMap(),
      );

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
