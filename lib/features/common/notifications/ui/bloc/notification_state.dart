part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.permissionIsGranted = false,
    this.status = NotificationStatus.initial,
    required this.route,
    required this.notification,
  });

  final bool permissionIsGranted;
  final NotificationStatus status;
  final NotificationEntity notification;
  final InitialRouteEntity route;

  factory NotificationState.empty() => NotificationState(
        notification: NotificationEntity.empty(),
        route: InitialRouteEntity(
          name: InitialRoute.notDefined,
        ),
      );

  NotificationState copyWith({
    bool? permissionIsGranted,
    NotificationStatus? status,
    NotificationEntity? notification,
    InitialRouteEntity? route,
  }) {
    return NotificationState(
      permissionIsGranted: permissionIsGranted ?? this.permissionIsGranted,
      status: status ?? this.status,
      notification: notification ?? this.notification,
      route: route ?? this.route,
    );
  }

  @override
  List<Object> get props => [permissionIsGranted, status, notification, route];
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
