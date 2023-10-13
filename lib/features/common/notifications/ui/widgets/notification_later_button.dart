import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';

class NotificationLaterButton extends StatelessWidget {
  const NotificationLaterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        context.read<AnalyticsBloc>().add(
              LogEvent('laterNotificationsButtonPressed'),
            );

        context.read<NotificationBloc>().add(GetNextRouteEvent());
      },
      child: Text('Más tarde'),
    );
  }
}
