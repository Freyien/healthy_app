import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/common/notifications/data/notification_controller.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(
    this._notifications,
    this._notificationsFcm,
    this._functions,
    this._prefs,
  );

  final AwesomeNotifications _notifications;
  final AwesomeNotificationsFcm _notificationsFcm;
  final FirebaseFunctions _functions;
  final SharedPreferences _prefs;

  /* PERMISSIONS */

  @override
  Future<Response<PermissionStatusEntity>> checkNotificationPermission() async {
    try {
      final status = await Permission.notification.status;
      final permissionStatus =
          PermissionStatusEntity.fromPermissionStatus(status);

      return Response.success(permissionStatus);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> openNotificationSettings() async {
    try {
      final type = Platform.isAndroid
          ? AppSettingsType.notification
          : AppSettingsType.settings;

      await AppSettings.openAppSettings(
        type: type,
        asAnotherTask: true,
      );

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<PermissionStatusEntity>> requestPermission() async {
    try {
      final status = await Permission.notification.request();

      final permissionStatus =
          PermissionStatusEntity.fromPermissionStatus(status);

      return Response.success(permissionStatus);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  /* INITIAL CONFIG */

  @override
  Future<void> initRemoteNotifications() async {
    await _initializeRemoteNotifications();
  }

  @override
  Future<void> initLocalNotifications() async {
    _initializeLocalNotifications();
  }

  /* TOKENS */

  @override
  Future<void> savetoken() async {
    try {
      final token = await _notificationsFcm.requestFirebaseAppToken();

      await _saveToken(token);

      NotificationController.streamFcmToken.stream.listen((token) async {
        await _saveToken(token);
      });
    } catch (e) {
      print(e);
    }
  }

  /* NOTIFICATIONS */

  @override
  Future<Response<NotificationEntity?>> getInitialMessage() async {
    try {
      final receivedAction = await _notifications.getInitialNotificationAction(
        removeFromActionEvents: true,
      );

      if (receivedAction == null) return Response.success(null);

      final notification =
          NotificationEntity.fromReceivedAction(receivedAction);

      return Response.success(notification);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Stream<NotificationEntity> onActionReceivedMethod() {
    _notifications.setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );

    return NotificationController.streamReceivedAction.stream;
  }

  @override
  Future<Response<void>> showNotification({
    required NotificationEntity notification,
  }) async {
    try {
      await _notifications.createNotification(
        content: NotificationContent(
          channelKey: 'basic_channel',
          id: notification.id,
          title: notification.title,
          body: notification.body,
          wakeUpScreen: true,
          category: NotificationCategory.Reminder,
          autoDismissible: false,
        ),
      );

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  /* TOPICS */

  @override
  Future<void> suscribeToCommonTipics() async {
    try {
      await _suscribeTopic("news");
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> unsuscribeToCommonTipics() async {
    try {
      await _unsuscribeTopic("news");
    } catch (e) {
      print(e);
    }
  }

  /* PRIVATE METHODS */

  void _initializeLocalNotifications() {
    _notifications.initialize(
      // 'app_icon',
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic channel',
          channelDescription: 'Notification channel for basic',
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
          importance: NotificationImportance.High,
          playSound: true,
        ),
        NotificationChannel(
          channelGroupKey: 'water_reminder_channel_group',
          channelKey: HealthyConstants.waterReminderChannel,
          channelName: 'Water Reminder Channel',
          channelDescription: 'Water Reminder Channel',
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
          importance: NotificationImportance.High,
          playSound: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic Channel Group',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'water_reminder_channel_group',
          channelGroupName: 'Water Reminder Group',
        ),
      ],
      debug: true,
    );
  }

  Future<void> _initializeRemoteNotifications() async {
    await _notificationsFcm.initialize(
      onFcmTokenHandle: NotificationController.onFcmTokenHandle,
      onFcmSilentDataHandle: NotificationController.onFcmSilentDataHandle,
      licenseKeys:
          // On this example app, the app ID / Bundle Id are different
          // for each platform, so i used the main Bundle ID + 1 variation
          [
        // me.carda.awesomeNotificationsFcmExample
        '2024-01-02==kZDwJQkSR7mrjEgDk7afWDSrqYCiqW6Ao/7wn/w6v5OKOgAnoEWt'
            'gqO0ELI1BxWNzSde2gbaW+9Ki6Tx94pU2gQRJuJxXGsvcmCRla1mB/0U/rPh'
            'f77bxgPRG+PHn9+p9sQ5nfvY6Ytw9IvDn4NjH3ccbjoXFRrs7R/ou9aapq2a'
            'jRHqXlIzDR1ihyQHC91Wvkviw2qTOEYDhR5hE4T2l1iHsTTpeXOqWk0XmgnC'
            'gO18e4Hv0P5WKICCull+PCh+OXQYTK5x0UwQPNOGN20rQu5zR9C0ph0hFQxk'
            'WLa/ft206pBZmWDf4HiyAawXPoR1AMWAh/t0cjh8gRTTNfHeog==',

        // me.carda.awesome_notifications_fcm_example
        '2024-01-02==lYUBqt9kKmObnP7UzWd2KK9FOTOySkVATX/j/CGEzSlSKsQx5y5S9'
            'RKHG1lP1TZ5KHO6+wwkNbzxmni4uJ418WM3ywTY199bHAp5MHWxZEEgvMMG4/'
            '/V2W0acFhSgxH6GL/6XNYvhS2RwaX7X/z4NX7Z4dgZVOn0VW3GRyg7I/zLcgl'
            'Dhh+n9obRuGnZI+Xakw2id97PSG4QZOCw15A0LzE1lip/Fzj0cMRsqpvcAW2K'
            'VWYZm5ZmK2yKVcop1kxiq1faZGL1fBteJCQ8YeQKpqS+aaVmexdJXmB7sJVl0'
            '5o87ORRfijpO+Q6gmTYfjYxoiQMismHUx6NAnoB/txaLw=='
      ],
      debug: true,
    );
  }

  Future<void> _saveToken(String token) async {
    if (token.isEmpty) return;

    final savedToken = _prefs.get('notificationToken');
    if (savedToken.toString() == token) return;

    // Save token in server
    await _functions.httpsCallable('saveNotificationToken').call({
      'token': token,
    });

    // Save token in local
    await _prefs.setString('notificationToken', token);
  }

  Future<void> _suscribeTopic(String topic) async {
    final isSuscribed = await _prefs.getBool(topic) ?? false;

    if (isSuscribed) return;

    await _notificationsFcm.subscribeToTopic(topic);
    await _prefs.setBool(topic, true);
  }

  Future<void> _unsuscribeTopic(String topic) async {
    await _notificationsFcm.unsubscribeToTopic(topic);
    await _prefs.setBool(topic, false);
  }
}
