import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';

class NotificationActivateButton extends StatelessWidget {
  const NotificationActivateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Activar notificaciones',
      onPressed: () {
        context.read<AnalyticsBloc>().add(
              LogEvent('activateNotificationsButtonPressed'),
            );

        context.read<NotificationBloc>().add(
              RequestPermissionEvent(),
            );
      },
    );
  }
}
