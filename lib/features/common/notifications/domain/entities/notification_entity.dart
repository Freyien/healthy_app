import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_app/core/domain/utils/enum_utils.dart';

class NotificationEntity extends Equatable {
  NotificationEntity({
    this.id = 0,
    this.messageId = '',
    this.title = '',
    this.body = '',
    this.data = const {},
    this.imageUrl = '',
  });

  final int id;
  final String messageId;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final String imageUrl;

  factory NotificationEntity.empty() {
    return NotificationEntity();
  }

  factory NotificationEntity.fromRemoteMessage(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    return NotificationEntity(
      messageId: message.messageId ?? '',
      body: notification?.body ?? data['body'] ?? '',
      title: notification?.title ?? data['title'] ?? '',
      data: data,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  factory NotificationEntity.fromPendingNotification(
    PendingNotificationRequest notification,
  ) {
    String payload = notification.payload ?? '';
    payload = payload.isEmpty ? '{}' : payload;

    final payloadDecode = jsonDecode(payload);
    final data = Map<String, dynamic>.from(payloadDecode);

    return NotificationEntity(
      id: notification.id,
      messageId: notification.id.toString(),
      body: notification.body ?? '',
      title: notification.title ?? '',
      data: data,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  factory NotificationEntity.fromJson(String source) =>
      NotificationEntity.fromMap(json.decode(source));

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      id: map['id'] ?? UniqueKey().hashCode,
      messageId: map['message_id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      data: Map<String, dynamic>.from(map['data'] ?? map),
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  NotificationType get type {
    return EnumUtils.stringToEnum(
          NotificationType.values,
          data['type'] ?? '',
        ) ??
        NotificationType.initial;
  }

  NotificationEntity copyWith({
    int? id,
    String? messageId,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    String? imageUrl,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      messageId,
      title,
      body,
      data,
      imageUrl,
    ];
  }
}

enum NotificationType {
  initial,
  waterReminder,
  eatingReminder,
}
