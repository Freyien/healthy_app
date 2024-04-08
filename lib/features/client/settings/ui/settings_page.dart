import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/domain/enums/signout_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/settings/ui/bloc/settings_bloc.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/appointment_section.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/bloc/appointment_bloc.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/account_option.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/app_version.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/client_info.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/notification_option.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SettingsBloc>()
            ..add(FetchAppVersionEvent())
            ..add(GetClientEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cuenta'),
          actions: [
            if (Platform.isIOS)
              PopupMenuButton(
                initialValue: null,
                onSelected: (name) {
                  context.pushNamed(name);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'delete_account',
                    child: Text('Eliminar cuenta (1/3)'),
                  ),
                ],
                icon: Icon(Icons.more_vert_rounded),
              ),
          ],
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            return MultiBlocListener(
              listeners: [
                BlocListener<SettingsBloc, SettingsState>(
                  listenWhen: (p, c) => p.signOutStatus != c.signOutStatus,
                  listener: _settingsListener,
                ),
                BlocListener<AppointmentBloc, AppointmentState>(
                  listenWhen: (p, c) => p.savingStatus != c.savingStatus,
                  listener: _appointmentListener,
                ),
              ],
              child: ScrollFillRemaining(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VerticalSpace.xsmall(),

                    // Client info
                    ClientInfo(),
                    VerticalSpace.large(),
                    Spacer(),

                    // Appointment
                    AppointmentSection(),

                    // Sugestions
                    AccountOption(
                      icon: Icons.message_outlined,
                      title: 'Sugerencias',
                      onTap: () {
                        context.pushNamed('suggestion');
                      },
                    ),

                    // Notifications
                    NotificationOption(),

                    // Sign out
                    AccountOption(
                      icon: Icons.exit_to_app_outlined,
                      title: 'Cerrar sesión',
                      onTap: () async {
                        context.read<AnalyticsBloc>().add(LogEvent('signOut'));
                        context.read<SettingsBloc>().add(SignOutEvent());
                      },
                    ),
                    VerticalSpace.large(),

                    // Version
                    AppVersion(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _settingsListener(BuildContext context, SettingsState state) {
    switch (state.signOutStatus) {
      case SignOutStatus.initial:
        break;
      case SignOutStatus.loading:
        LoadingUtils.show(context);
        break;
      case SignOutStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SignOutStatus.closed:
        LoadingUtils.hide(context);

        context.pushReplacementNamed('sign_in');
        break;
    }
  }

  void _appointmentListener(BuildContext context, AppointmentState state) {
    switch (state.savingStatus) {
      case SavingStatus.initial:
        break;
      case SavingStatus.loading:
        LoadingUtils.show(context);
        break;
      case SavingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SavingStatus.success:
        LoadingUtils.hide(context);
        return Toast.showSuccess('Tu cita ha sido confirmada');
    }
  }
}
