import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/di/di_business.dart';
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

  void _notificationListener(BuildContext context, NotificationState state) {
    switch (state.status) {
      case NotificationStatus.permissionChecked:
        if (state.requestStatus != AuthorizationStatus.authorized) return;

        return _onAutorizedPermission(context);
      case NotificationStatus.notificationTapped:
        return _onNotificationTapped(context, state.notification);
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
      case NotificationType.offer:
        navigationShell.goBranch(3, initialLocation: true);
        context.pushNamed(
          'offer_detail',
          extra: notification.offer,
        );
      case NotificationType.product:
        navigationShell.goBranch(0, initialLocation: true);
        context.pushNamed(
          'product_detail',
          extra: notification.product,
        );
      case NotificationType.reward:
        return;
    }
  }
}
