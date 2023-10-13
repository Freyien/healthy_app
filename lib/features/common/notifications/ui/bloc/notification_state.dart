part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.requestStatus = AuthorizationStatus.notDetermined,
    this.status = NotificationStatus.initial,
    required this.route,
    required this.notification,
  });

  final AuthorizationStatus requestStatus;
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
    AuthorizationStatus? requestStatus,
    NotificationStatus? status,
    NotificationEntity? notification,
    InitialRouteEntity? route,
  }) {
    return NotificationState(
      requestStatus: requestStatus ?? this.requestStatus,
      status: status ?? this.status,
      notification: notification ?? this.notification,
      route: route ?? this.route,
    );
  }

  @override
  List<Object> get props => [requestStatus, status, notification, route];
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
