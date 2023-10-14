import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/sign_in/ui/bloc/sign_in_bloc.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class SignInGoogleButton extends StatelessWidget {
  const SignInGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      onPressed: () {
        context
            .read<AnalyticsBloc>()
            .add(LogEvent('GoogleSignInButtonPressed'));

        context.read<SignInBloc>().add(SignInwithGoogleEvent());
      },
      text: 'Continuar con Google',
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Image.asset(
          'assets/images/google_icon.png',
          width: 25,
        ),
      ),
    );
  }
}
