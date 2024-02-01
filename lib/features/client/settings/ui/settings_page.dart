import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/signout_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/settings/ui/bloc/settings_bloc.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/account_option.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/app_version.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/notification_option.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsBloc>()..add(FetchAppVersionEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configuración'),
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            return BlocListener<SettingsBloc, SettingsState>(
              listener: _settingsListener,
              child: ScrollFillRemaining(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    AccountOption(
                      icon: Icons.message_outlined,
                      title: 'Sugerencias',
                      onTap: () {
                        context.pushNamed('suggestion');
                      },
                    ),
                    NotificationOption(),
                    AccountOption(
                      icon: Icons.exit_to_app_outlined,
                      title: 'Cerrar sesión',
                      onTap: () async {
                        context.read<AnalyticsBloc>().add(LogEvent('signOut'));
                        context.read<SettingsBloc>().add(SignOutEvent());
                      },
                    ),
                    VerticalSpace.large(),
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
}
