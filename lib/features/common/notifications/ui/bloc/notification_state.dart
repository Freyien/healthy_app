part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.permissionStatus,
    this.status = NotificationStatus.initial,
    required this.route,
    required this.notification,
  });

  final PermissionStatusEntity permissionStatus;
  final NotificationStatus status;
  final NotificationEntity notification;
  final InitialRouteEntity route;

  factory NotificationState.empty() => NotificationState(
        permissionStatus: PermissionStatusEntity.initial(),
        notification: NotificationEntity.empty(),
        route: InitialRouteEntity(
          name: InitialRoute.notDefined,
        ),
      );

  NotificationState copyWith({
    PermissionStatusEntity? permissionStatus,
    NotificationStatus? status,
    NotificationEntity? notification,
    InitialRouteEntity? route,
  }) {
    return NotificationState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
      status: status ?? this.status,
      notification: notification ?? this.notification,
      route: route ?? this.route,
    );
  }

  @override
  List<Object> get props => [permissionStatus, status, notification, route];
}

enum NotificationStatus {
  initial,
  loading,
  success,
  failure,
  permissionRequested,
  notificationTapped,
  permissionChecked,
  settingsOpened,
}
