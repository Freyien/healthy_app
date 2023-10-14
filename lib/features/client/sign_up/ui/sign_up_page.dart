import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/scroll_fill_remaining.dart';
import 'package:healthy_app/core/ui/widgets/sign_in_apple_button.dart';
import 'package:healthy_app/core/ui/widgets/vertical_space.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/sign_in/ui/widgets/or_separator.dart';
import 'package:healthy_app/features/client/sign_up/ui/bloc/sign_up_bloc.dart';
import 'package:healthy_app/features/client/sign_up/ui/widgets/form.dart';
import 'package:healthy_app/features/client/sign_up/ui/widgets/have_account.dart';
import 'package:healthy_app/features/client/sign_up/ui/widgets/sign_up_google_button.dart';
import 'package:healthy_app/features/client/sign_up/ui/widgets/subtitle.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>(),
      child: LayoutBuilder(builder: (context, constraints) {
        return BlocListener<SignUpBloc, SignUpState>(
          listener: _signUpListener,
          child: Scaffold(
            body: SafeArea(
              child: ScrollFillRemaining(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Spacer(),

                    // Logo
                    FlutterLogo(
                      size: constraints.maxHeight * .18,
                    ),
                    VerticalSpace.xxxlarge(),

                    // Subtitle
                    const SignUpSubtitle(),
                    VerticalSpace.xxsmall(),

                    // Form
                    const SignUpForm(),
                    VerticalSpace.large(),

                    // You have account?
                    const HaveAccount(),
                    VerticalSpace.large(),

                    // Or separator
                    const OrSeparator(),
                    VerticalSpace.xxlarge(),

                    // Google Sign Up
                    const SignUpGoogleButton(),
                    VerticalSpace.small(),

                    // Apple Sign Up
                    SignUpAppleButton(
                      onPressed: () {
                        context.read<SignUpBloc>().add(SignUpwithAppleEvent());
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _signUpListener(BuildContext context, SignUpState state) {
    switch (state.status) {
      case SignUpStatus.initial:
        break;
      case SignUpStatus.loading:
        LoadingUtils.show(context);
        break;
      case SignUpStatus.failure:
        LoadingUtils.hide(context);
        _showFailure(state.failure);
        break;
      case SignUpStatus.success:
        LoadingUtils.hide(context);

        context.read<AnalyticsBloc>().add(LogEvent('logged'));
        context.goNamed('home');
        break;
    }
  }

  void _showFailure(SignUpFailure failure) {
    switch (failure) {
      case SignUpFailure.none:
      case SignUpFailure.socialMediaCanceledFailure:
        break;
      case SignUpFailure.unexpected:
        Toast.showError('Ha ocurrido un error inesperado.');
        break;
      case SignUpFailure.passwordTooWeakFailure:
        Toast.showError('Contraseña es muy débil, intenta con otra.');
        break;
      case SignUpFailure.accountAlreadyExistsFailure:
        Toast.showError('Este correo ya ha sido registrado previamente.');
        break;
    }
  }
}
