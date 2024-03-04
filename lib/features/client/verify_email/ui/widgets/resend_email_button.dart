import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/verify_email/ui/bloc/verify_email_bloc.dart';

class ResendEmailButton extends StatelessWidget {
  const ResendEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
      buildWhen: (p, c) => p.enabledButton != c.enabledButton,
      builder: (context, state) {
        final enabledButton = state.enabledButton;

        return PrimaryButton(
          text: 'Reenviar correo',
          onPressed: enabledButton
              ? () {
                  context
                      .read<VerifyEmailBloc>()
                      .add(ResendEmailVerificationEvent());
                }
              : null,
        );
      },
    );
  }
}
