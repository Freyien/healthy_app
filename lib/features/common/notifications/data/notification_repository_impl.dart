import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/common/notifications/data/notification_controller.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
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
  Future<Response<NotificationPermissionStatus>>
      checkNotificationPermission() async {
    try {
      final permissionList = await _notifications.checkPermissionList();

      if (permissionList.isNotEmpty) {
        return Response.success(NotificationPermissionStatus.granted);
      }

      final attempts = _prefs.getInt('notificationPermissionAttempt') ?? 0;
      final status = attempts >= 2
          ? NotificationPermissionStatus.permanentlyDenied
          : NotificationPermissionStatus.denied;

      return Response.success(status);
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
  Future<Response<void>> requestPermission() async {
    try {
      await _notifications.requestPermissionToSendNotifications();

      final attempts = _prefs.getInt('notificationPermissionAttempt') ?? 0;
      _prefs.setInt('notificationPermissionAttempt', attempts + 1);

      return Response.success(null);
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
  Future<void> saveToken() async {
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

  @override
  Future<void> deleteToken() async {
    try {
      final token = _prefs.getString('notificationToken') ?? '';
      if (token.isEmpty) return;

      // Delete token in local
      await _prefs.remove('notificationToken');

      // Delete token in server
      await _functions.httpsCallable('deleteNotificationToken').call({
        'token': token,
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
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic channel',
          channelDescription: 'Notification channel for basic',
          defaultColor: HealthyConstants.primaryColor,
          ledColor: HealthyConstants.primaryColor,
          importance: NotificationImportance.High,
          playSound: true,
        ),
        NotificationChannel(
          channelGroupKey: 'water_reminder_channel_group',
          channelKey: HealthyConstants.waterReminderChannel,
          channelName: 'Water Reminder Channel',
          channelDescription: 'Water Reminder Channel',
          defaultColor: HealthyConstants.primaryColor,
          ledColor: HealthyConstants.primaryColor,
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
      debug: kDebugMode,
    );
  }

  Future<void> _initializeRemoteNotifications() async {
    await _notificationsFcm.initialize(
      onFcmTokenHandle: NotificationController.onFcmTokenHandle,
      onFcmSilentDataHandle: NotificationController.onFcmSilentDataHandle,
      licenseKeys: [
        '2024-02-04==LllzEf0nRpjBft6O2DEcvEAttb66x0fdNpM4egDqn2ZJX3hVc3NvsmSuqum6Ad0dFkyIINRua90QMnMVDq/9f83TOuHlfKdJD4BuhMrC2s+DgIOzxDY+6LNNS16euiWxPeIxji3LDPghaNvpxYXTjCxcVB7Z25U9AjcLXkcu4QHVOb5/ppz3pMBakr7/8z/9aBOKpP0yseY7h8AWK6eRQ9GSwHNdLOQM9soMNMUYt4zEJkA8zcBJNf3spiZ3z+XCBIRMggYBH8uU3IXP0TYHzS4D4CKW72zlZ6bG2p4ciakSR0Aa84MBRU2y1ruQveVwKZrCN7jkxrBiyqhaKI7dpQ==',
        '2024-02-04==lfXijWhj/TxU+ehowCX3TkNZWQ8hGO4kul4FcqEyD3pK0xCmsmQH0LTHpsLVkWlzoQVb9cLo8L5fhk14bNT1jobyXNI6ZTvik9KVFM2AbGeRmyeBYufwHJPveH/Y7jKr9Oy0bnUUuN+MORegW3+VZeFgMmxJBYaQsI7Q3ZVozVOtNPj8jmGNRU7L04/AyzjQP9bjerntH4hTGb3JANPdqvt4A2fMOQWoXoCeH3mKIxIJMQ8Ui1MRtnHo8AsrFcrvzWnoGHdBuTU3FTavcJBbjHMh7IkZBrq9LIreNw94GCrugPdZuFMu5fXdOB5RGvVpc/pjVUgolvU5pAekrUBbxw==',
        '2024-02-04==htMC4HYUvR4n3dJ6M9racuQ9N2ni1UnXvXj7fTM2ZjYWNZ7BIq4cr1nd+q+4rW3WHMIxPFpHw2skfAoWCLwyj1AJggdm8stNiUmzNcoSyhdFez33ZWMNRux18eukiAvg3VJNhTEA/+Pga16Eex65uTKs2p2dYhfo6lBc+nmFUiq9/losE7CTVTpLezKYyl0a3vaS4Q7EYG2YdnWFAv1qB5tjmJp7swZjhhX2iGRd5/XHmd97GPjJ2hMwEcJhe3lVUjjPegCZSDTPwmFnK0XRlduxbqd+4VJd2gBR2alLqzTgWLP4z9MNjrpECinKGb5wWwSpXpaLKECrxLgn1hAa3g=='
      ],
      debug: kDebugMode,
    );
  }

  Future<void> _saveToken(String token) async {
    if (token.isEmpty) return;

    final savedToken = _prefs.getString('notificationToken') ?? '';
    if (savedToken == token) return;

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
