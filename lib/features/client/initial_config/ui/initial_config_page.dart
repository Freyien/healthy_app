import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
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
          sl<InitialConfigBloc>()..add(CheckEmailVerifiedEvent()),
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<InitialConfigBloc, InitialConfigState>(
                listenWhen: (p, c) =>
                    p.emailVerifyStatus != c.emailVerifyStatus,
                listener: _emailVerifyListener,
              ),
              BlocListener<InitialConfigBloc, InitialConfigState>(
                listenWhen: (p, c) =>
                    p.initialConfigStatus != c.initialConfigStatus,
                listener: _initialConfigListener,
              ),
              BlocListener<InitialConfigBloc, InitialConfigState>(
                listenWhen: (p, c) =>
                    p.completeOnboardingStatus != c.completeOnboardingStatus,
                listener: _completeOnboardingListener,
              ),
            ],
            child: BlocBuilder<InitialConfigBloc, InitialConfigState>(
              builder: (context, state) {
                // Failure
                if (state.initialConfigStatus == FetchingStatus.failure ||
                    state.emailVerifyStatus == FetchingStatus.failure ||
                    state.completeOnboardingStatus == SavingStatus.failure) {
                  return ErrorFullScreen(
                    onRetry: () {
                      context
                          .read<InitialConfigBloc>()
                          .add(CheckEmailVerifiedEvent());
                    },
                  );
                }

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
      ),
    );
  }

  void _emailVerifyListener(BuildContext context, InitialConfigState state) {
    if (state.emailVerifyStatus != FetchingStatus.success) return;

    if (!state.emailVerified) //
      return context.goNamed('verify_email');

    context.read<InitialConfigBloc>().add(GetInitialConfigEvent());
  }

  void _initialConfigListener(BuildContext context, InitialConfigState state) {
    if (state.initialConfigStatus != FetchingStatus.success) return;

    if (!state.initialConfig.personalInfo) //
      return context.goNamed('personal_info');

    if (!state.initialConfig.doctorCode) //
      return context.goNamed('doctor_code');

    context.read<InitialConfigBloc>().add(CompleteOnboardingEvent());
  }

  void _completeOnboardingListener(
      BuildContext context, InitialConfigState state) {
    if (state.completeOnboardingStatus != SavingStatus.success) return;

    return context.goNamed('home');
  }
}
