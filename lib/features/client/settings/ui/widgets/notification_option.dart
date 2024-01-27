import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/common/notifications/ui/bloc/notification_bloc.dart';

import 'account_option.dart';

class NotificationOption extends StatefulWidget {
  const NotificationOption({super.key});

  @override
  State<NotificationOption> createState() => _NotificationOptionState();
}

class _NotificationOptionState extends State<NotificationOption>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        final bloc = context.read<NotificationBloc>();
        if (bloc.state.status != NotificationStatus.settingsOpened) //
          return;

        context.read<NotificationBloc>().add(CheckPermissionEvent());
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      buildWhen: (_, c) =>
          c.status == NotificationStatus.permissionChecked ||
          c.status == NotificationStatus.permissionRequested,
      builder: (context, state) {
        final requestStatus = state.requestStatus;

        if (requestStatus == AuthorizationStatus.authorized)
          return AccountOption(
            icon: Icons.notifications,
            title: 'Configurar recordatorios',
            onTap: () async {},
          );

        return AccountOption(
          icon: Icons.notifications,
          iconWidget: Stack(
            children: [
              Icon(Icons.notifications),
              Positioned(
                right: 0,
                top: -5,
                child: FadeInDown(
                  from: 10,
                  delay: Duration(microseconds: 250),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.appColors.primary,
                    ),
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: 'Activar Notificationes',
          subtitle: 'Otorga el permiso para recibir notificaciones',
          onTap: () async {
            if (requestStatus == AuthorizationStatus.notDetermined) {
              return context
                  .read<NotificationBloc>()
                  .add(RequestPermissionEvent());
            }
            return context
                .read<NotificationBloc>()
                .add(OpenNotificationSettingsEvent());
          },
        );
      },
    );
  }
}
