import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';

class DashboardNotifications extends StatelessWidget {
  const DashboardNotifications({
    super.key,
    required this.navigationShell,
    required this.child,
  });

  final StatefulNavigationShell navigationShell;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationBloc>()..add(CheckPermissionEvent()),
      child: BlocListener<NotificationBloc, NotificationState>(
        listener: _notificationListener,
        child: child,
      ),
    );
  }

  Future<void> _notificationListener(
    BuildContext context,
    NotificationState state,
  ) async {
    switch (state.status) {
      case NotificationStatus.permissionChecked:
        if (state.permissionStatus != NotificationPermissionStatus.granted)
          return;

        return _onAutorizedPermission(context);
      case NotificationStatus.notificationTapped:
        return _onNotificationTapped(context, state.notification);
      default:
    }
  }

  void _onAutorizedPermission(BuildContext context) {
    context.read<NotificationBloc>()
      ..add(InitLocalNotificationsEvent())
      ..add(InitRemoteNotificationsEvent())
      ..add(GetInitialMessageEvent())
      ..add(ActionReceivedMethodEvent())
      ..add(SuscribeToCommonTipics())
      ..add(SaveTokenEvent());
  }

  void _onNotificationTapped(
    BuildContext context,
    NotificationEntity notification,
  ) {
    context
        .read<AnalyticsBloc>()
        .add(LogEvent('notificationTapped', parameters: {
          'type': notification.type.name,
        }));

    switch (notification.type) {
      case NotificationType.initial:
        return;
      case NotificationType.waterReminder:
        return navigationShell.goBranch(1, initialLocation: true);
      case NotificationType.eatingReminder:
        return;
      case NotificationType.reminderAppointment:
      case NotificationType.newAppointment:
      case NotificationType.updateAppointment:
      case NotificationType.leaveNowAppointment:
      case NotificationType.cancelAppointment:
        return navigationShell.goBranch(3, initialLocation: true);
    }
  }
}
