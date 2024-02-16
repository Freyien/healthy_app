import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/sign_up/ui/bloc/sign_up_bloc.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class SignUpGoogleButton extends StatelessWidget {
  const SignUpGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      onPressed: () {
        context
            .read<AnalyticsBloc>()
            .add(LogEvent('GoogleSignUpButtonPressed'));

        context.read<SignUpBloc>().add(SignUpwithGoogleEvent());
      },
      text: 'Continuar con Google',
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: SvgPicture.asset(
          'assets/svg/google.svg',
          width: 25,
        ),
      ),
    );
  }
}
