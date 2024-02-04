import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/initial_config/ui/bloc/initial_config_bloc.dart';

class InitialConfigPage extends StatelessWidget {
  const InitialConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<InitialConfigBloc>()..add(GetInitialConfigEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<InitialConfigBloc, InitialConfigState>(
            listener: _initialConfigListener,
            builder: (context, state) {
              // Failure
              if (state.fetchingStatus == FetchingStatus.failure)
                return ErrorFullScreen(
                  onRetry: () {
                    context
                        .read<InitialConfigBloc>()
                        .add(GetInitialConfigEvent());
                  },
                );

              // Loading
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(animationName: 'fruits_loading'),
                    Transform.translate(
                      offset: Offset(0, -30),
                      child: Text(
                        'Obteniendo configuración...',
                        style: TextStyle(
                          color: context.appColors.textContrast,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _initialConfigListener(BuildContext context, InitialConfigState state) {
    if (state.fetchingStatus != FetchingStatus.success) return;

    if (!state.initialConfig.personalInfo) //
      return context.goNamed('personal_info');

    if (!state.initialConfig.doctorCode) //
      return context.goNamed('doctor_code');

    return context.goNamed('home');
  }
}
