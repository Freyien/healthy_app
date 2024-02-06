import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/core/ui/widgets/sign_in_apple_button.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/sign_in/ui/bloc/sign_in_bloc.dart';
import 'package:healthy_app/features/client/sign_in/ui/widgets/form.dart';
import 'package:healthy_app/features/client/sign_in/ui/widgets/have_account.dart';
import 'package:healthy_app/features/client/sign_in/ui/widgets/subtitle.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInBloc>(),
      child: LayoutBuilder(builder: (context, constraints) {
        return BlocListener<SignInBloc, SignInState>(
          listener: _signInListener,
          child: Scaffold(
            body: SafeArea(
              child: ScrollFillRemaining(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Spacer(),

                    // Logo
                    Image.asset(
                      'assets/images/logo.png',
                      height: constraints.maxHeight * .18,
                    ),
                    VerticalSpace.xxxlarge(),

                    // Subtitle
                    const SignInSubtitle(),
                    VerticalSpace.xxsmall(),

                    // Form
                    SignInForm(),
                    VerticalSpace.large(),

                    // Have an account
                    SignInHaveAccount(),
                    VerticalSpace.large(),

                    // Separator
                    OrSeparator(),
                    VerticalSpace.xxlarge(),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google button
                        SignInGoogleButton(
                          onPressed: () => _onGoogleSignIn(context),
                        ),

                        // Apple button
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SignInAppleButton(
                            onPressed: () => _onAppleSignIn(context),
                          ),
                        ),
                      ],
                    ),

                    // Apple Sign Up
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

  void _onGoogleSignIn(BuildContext context) {
    context.read<AnalyticsBloc>().add(LogEvent('GoogleSignInButtonPressed'));

    context.read<SignInBloc>().add(SignInwithGoogleEvent());
  }

  void _onAppleSignIn(BuildContext context) {
    context.read<AnalyticsBloc>().add(LogEvent('AppleSignInButtonPressed'));

    context.read<SignInBloc>().add(SignInwithAppleEvent());
  }

  void _signInListener(BuildContext context, SignInState state) {
    switch (state.status) {
      case SignInStatus.initial:
        break;
      case SignInStatus.loading:
        LoadingUtils.show(context);
        break;
      case SignInStatus.failure:
        LoadingUtils.hide(context);
        _showFailure(state.failure);
        break;
      case SignInStatus.success:
        LoadingUtils.hide(context);

        context.read<AnalyticsBloc>().add(LogEvent('logged'));
        context.goNamed('initial_config');
        break;
    }
  }

  void _showFailure(SignInFailure failure) {
    switch (failure) {
      case SignInFailure.none:
      case SignInFailure.socialMediaCanceledFailure:
        break;
      case SignInFailure.unexpected:
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SignInFailure.invalidCredentialsFailure:
        return Toast.showError('Correo o contraseña son incorrectos.');
      case SignInFailure.userNotFound:
        return Toast.showError(
            'Correo no registrado, crea una cuenta para acceder.');
    }
  }
}
