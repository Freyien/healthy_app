import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/water_reminder/data/datasource/water_reminder_firebase_datasource.dart';
import 'package:healthy_app/features/client/water_reminder/data/datasource/water_reminder_server_datasource.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';

class WaterReminderRepositoryImpl implements WaterReminderRepository {
  final WaterReminderFirebaseDatasource _firebase;
  final WaterReminderServerDatasource _server;

  WaterReminderRepositoryImpl(this._firebase, this._server);

  @override
  Future<Response<WaterReminderEntity>> getWaterReminder() async {
    try {
      final waterReminder = await _firebase.getWaterReminder();

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
      await _server.saveWaterReminder(waterReminder);

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
