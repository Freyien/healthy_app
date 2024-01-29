import 'package:flutter/foundation.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/water_reminder/data/water_reminder_controller.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:workmanager/workmanager.dart';

class WaterReminderRepositoryImpl implements WaterReminderRepository {
  final CloudClient _client;
  final Workmanager _workmanager;

  WaterReminderRepositoryImpl(this._client, this._workmanager);

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

  @override
  Future<Response<NotificationEntity>> getWaterNotification() async {
    try {
      final result = await _client.get(
        'getWaterNotification',
        useCache: false,
      );

      final notification = NotificationEntity.fromMap(result);

      notification.data.addAll({
        'type': NotificationType.waterReminder.name,
      });

      return Response.success(notification);
    } catch (e) {
      final notificationId = UniqueKey().hashCode;
      final notification = NotificationEntity(
        id: notificationId,
        title: 'Tomar agua es importante',
        body: 'Tu cuerpo te lo agradecerá',
        data: {
          'type': NotificationType.waterReminder,
        },
        messageId: notificationId.toString(),
      );
      return Response.success(notification);
    }
  }

  @override
  Future<Response<void>> addLocalWaterReminder(
    WaterReminderEntity waterReminder, {
    bool replaceIfExists = true,
  }) async {
    try {
      final secondsDelay = waterReminder.calculateNextSecondsReminder;
      final existingWorkPolicy = replaceIfExists //
          ? ExistingWorkPolicy.replace
          : ExistingWorkPolicy.append;

      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: !kReleaseMode,
      );

      await Workmanager().registerOneOffTask(
        HealthyConstants.waterReminderChannel,
        HealthyConstants.waterReminderChannel,
        initialDelay: Duration(seconds: secondsDelay),
        existingWorkPolicy: existingWorkPolicy,
        inputData: waterReminder.toMap(),
      );

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> cancelWaterReminders() async {
    try {
      _workmanager.cancelByUniqueName(HealthyConstants.waterReminderChannel);
      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
