import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/water_reminder/domain/usecases/add_water_reminder_usecase.dart';
import 'package:healthy_app/features/client/water_reminder/domain/usecases/get_water_reminder_usecase.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
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
        if (state.requestStatus != AuthorizationStatus.authorized) return;

        return _onAutorizedPermission(context);
      case NotificationStatus.notificationTapped:
        return _onNotificationTapped(context, state.notification);
      case NotificationStatus.notificationReceived:
        return _onNotificationReceived(context, state.notification);
      default:
    }
  }

  void _onAutorizedPermission(BuildContext context) {
    context.read<NotificationBloc>()
      ..add(SetupForegroundNotificationEvent())
      ..add(ListenForegroundNotification())
      ..add(GetInitialMessageEvent())
      ..add(ListenOnMessageOpenedAppEvent())
      ..add(SuscribeToCommonTipics())
      ..add(SaveTokenEvent());
  }

  void _onNotificationTapped(
    BuildContext context,
    NotificationEntity notification,
  ) {
    switch (notification.type) {
      case NotificationType.initial:
        return;
      case NotificationType.waterReminder:
        return navigationShell.goBranch(1, initialLocation: true);
      case NotificationType.eatingReminder:
        return;
    }
  }

  Future<void> _onNotificationReceived(
    BuildContext context,
    NotificationEntity notification,
  ) async {
    switch (notification.type) {
      case NotificationType.initial:
        return;
      case NotificationType.waterReminder:
        return _scheduleWaterReminder();
      case NotificationType.eatingReminder:
        return;
    }
  }

  Future<void> _scheduleWaterReminder() async {
    final now = DateTime.now();
    final scheduleDate = await sl<GetWaterReminderDateUsecase>().call(now);
    await sl<AddWaterReminderUsecase>().call(scheduleDate);
  }
}
