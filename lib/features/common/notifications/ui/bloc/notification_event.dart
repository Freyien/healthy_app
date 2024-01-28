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

class InitRemoteNotificationsEvent extends NotificationEvent {}

class InitLocalNotificationsEvent extends NotificationEvent {}

class SaveTokenEvent extends NotificationEvent {}

class GetInitialMessageEvent extends NotificationEvent {}

class ActionReceivedMethodEvent extends NotificationEvent {}

class SuscribeToCommonTipics extends NotificationEvent {}
