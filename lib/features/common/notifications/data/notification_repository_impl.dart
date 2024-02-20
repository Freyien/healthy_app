import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(
    this._messaging,
    this._functions,
    this._prefs,
  );

  final FirebaseMessaging _messaging;
  final FirebaseFunctions _functions;
  final SharedPreferences _prefs;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late StreamController<NotificationEntity> streamController;
  late StreamSubscription streamSub;

  /* PERMISSIONS */

  @override
  Future<Response<NotificationPermissionStatus>>
      checkNotificationPermission() async {
    try {
      final settings = await _messaging.getNotificationSettings();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
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
      await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

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
    await _initializeLocalNotifications();
  }

  /* TOKENS */

  @override
  Future<void> saveToken() async {
    try {
      final token = await _messaging.getToken() ?? '';

      await _saveToken(token);

      _messaging.onTokenRefresh.listen((token) async {
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
      // FCM
      final remoteMessage = await _messaging.getInitialMessage();

      if (remoteMessage != null) {
        final message = NotificationEntity.fromRemoteMessage(remoteMessage);
        return Response.success(message);
      }

      // Local notifications
      final notificationAppLaunch = await _flutterLocalNotificationsPlugin
          .getNotificationAppLaunchDetails();

      if (notificationAppLaunch == null) return Response.success(null);

      if (notificationAppLaunch.didNotificationLaunchApp) {
        final notification = notificationAppLaunch.notificationResponse;
        final payload = notification?.payload ?? '{}';
        final message = NotificationEntity.fromJson(payload);

        return Response.success(message);
      }

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Stream<NotificationEntity> onTapNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      final notification = NotificationEntity.fromRemoteMessage(remoteMessage);

      streamController.add(notification);
    });

    return streamController.stream;
  }

  @override
  Future<void> showNotification(notification) async {
    _showLocalNotification(notification);
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

  @override
  Future<void> closeStreams() async {
    try {
      await streamSub.cancel();
      await streamController.close();
    } catch (e) {
      print('HOLA MUNDO MUNDIAL');
    }
  }

  /* PRIVATE METHODS */

  Future<void> _initializeLocalNotifications() async {
    streamController = StreamController<NotificationEntity>();
    final _onDidReceiveNotification = (NotificationResponse notification) {
      streamController.add(
        NotificationEntity.fromJson(notification.payload ?? '{}'),
      );
    };

    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        'app_icon',
      ),
      iOS: DarwinInitializationSettings(),
    );

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotification,
    );
  }

  Future<void> _initializeRemoteNotifications() async {
    _messaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    // Notifications from FCM in foreground
    streamSub =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = NotificationEntity.fromRemoteMessage(message);

      _showLocalNotification(notification);
    });
  }

  Future<void> _saveToken(String token) async {
    if (token.isEmpty) return;

    final savedToken = _prefs.getString('notificationToken') ?? '';
    if (kDebugMode) log('[FCM Token]: $savedToken');
    if (savedToken == token) return;

    // Save token in server
    await _functions.httpsCallable('saveNotificationToken').call({
      'token': token,
    });

    // Save token in local
    await _prefs.setString('notificationToken', token);
  }

  Future<void> _showLocalNotification(NotificationEntity notification) async {
    List<DarwinNotificationAttachment> attachmentList = [];
    BigPictureStyleInformation? bigPictureStyleInformation;
    ByteArrayAndroidBitmap? imageBitMap;

    if (notification.imageUrl.isNotEmpty) {
      if (Platform.isIOS) {
        final imagePath = await _downloadAndSaveFile(
          notification.imageUrl,
          'bigPicture.jpg',
        );
        attachmentList.add(
          DarwinNotificationAttachment(imagePath),
        );
      } else if (Platform.isAndroid) {
        imageBitMap = await _getByteArrayFromUrl(notification.imageUrl);
        bigPictureStyleInformation = BigPictureStyleInformation(
          imageBitMap,
          hideExpandedLargeIcon: true,
        );
      }
    }

    final androidChannel = AndroidNotificationDetails(
      'luma_channel',
      'LuMa Notifications',
      importance: Importance.max,
      priority: Priority.max,
      largeIcon: imageBitMap,
      styleInformation: bigPictureStyleInformation,
      color: HealthyConstants.primaryColor,
      colorized: false,
    );

    final notificationDetails = NotificationDetails(
      android: androidChannel,
      iOS: DarwinNotificationDetails(
        interruptionLevel: InterruptionLevel.active,
        attachments: attachmentList,
      ),
    );

    final data = notification.data;

    data.addAll({
      'message_id': notification.hashCode.toString(),
      'title': notification.title,
      'body': notification.body,
    });

    await _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: json.encode(data),
    );
  }

  Future<void> _suscribeTopic(String topic) async {
    final isSuscribed = await _prefs.getBool(topic) ?? false;

    if (isSuscribed) return;

    await _messaging.subscribeToTopic(topic);
    await _prefs.setBool(topic, true);
  }

  Future<void> _unsuscribeTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    await _prefs.setBool(topic, false);
  }
}

Future<ByteArrayAndroidBitmap> _getByteArrayFromUrl(String url) async {
  final uri = Uri.parse(url);
  final http.Response response = await http.get(uri);

  return ByteArrayAndroidBitmap(
    response.bodyBytes,
  );
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}
