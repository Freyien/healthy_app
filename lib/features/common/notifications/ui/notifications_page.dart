import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/domain/utils/router_utils.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';
import 'package:healthy_app/features/common/notifications/ui/widgets/notification_activate_button.dart';
import 'package:healthy_app/features/common/notifications/ui/widgets/notification_animation.dart';
import 'package:healthy_app/features/common/notifications/ui/widgets/notification_later_button.dart';
import 'package:healthy_app/features/common/notifications/ui/widgets/notification_subtitle.dart';
import 'package:healthy_app/features/common/notifications/ui/widgets/notification_title.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationBloc>(),
      child: BlocListener<NotificationBloc, NotificationState>(
        listener: _notificationListener,
        child: Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ScrollFillRemaining(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Spacer(),
                      // Animation
                      NotificationAnimation(width: constraints.maxWidth * .7),
                      VerticalSpace.large(),

                      // Title
                      NotificationTitle(),
                      VerticalSpace.small(),

                      // Subtitle
                      NotificationSubtitle(),
                      Spacer(),
                      VerticalSpace.medium(),

                      // Activate notifications
                      NotificationActivateButton(),
                      VerticalSpace.medium(),

                      // Latter button
                      NotificationLaterButton(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _notificationListener(BuildContext context, NotificationState state) {
    switch (state.status) {
      case NotificationStatus.loading:
        return LoadingUtils.show(context);
      case NotificationStatus.permissionRequested:
        _logPermissionStatus(context, state.requestStatus);
        return _getNextRoute(context);
      case NotificationStatus.success:
      case NotificationStatus.failure:
        LoadingUtils.hide(context);
        _goToNextRoute(context, state.route);
        break;
      default:
    }
  }

  void _logPermissionStatus(BuildContext context, AuthorizationStatus status) {
    context.read<AnalyticsBloc>().add(
          LogEvent(
            'notificationStatus',
            parameters: {'status': status.toString()},
          ),
        );
  }

  void _getNextRoute(BuildContext context) {
    context.read<NotificationBloc>().add(GetNextRouteEvent());
  }

  void _goToNextRoute(BuildContext context, InitialRouteEntity route) {
    final location = RouterUtils.getLocation(route.name);
    context.go(location, extra: route.params);
  }
}
