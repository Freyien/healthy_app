part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class RequestPermissionEvent extends NotificationEvent {}

class GetNextRouteEvent extends NotificationEvent {}

class CheckPermissionEvent extends NotificationEvent {}

class OpenNotificationSettingsEvent extends NotificationEvent {}

class SetupForegroundNotificationEvent extends NotificationEvent {}

class SaveTokenEvent extends NotificationEvent {}

class GetInitialMessageEvent extends NotificationEvent {}

class ListenOnMessageOpenedAppEvent extends NotificationEvent {}

class ListenForegroundNotification extends NotificationEvent {}

class SuscribeToCommonTipics extends NotificationEvent {}
