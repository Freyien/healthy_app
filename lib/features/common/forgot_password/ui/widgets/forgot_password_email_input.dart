import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/sign_in/domain/entities/email_entity.dart';
import 'package:healthy_app/features/common/forgot_password/ui/bloc/forgot_password_bloc.dart';

class ForgotPasswordEmailInput extends StatelessWidget {
  const ForgotPasswordEmailInput({super.key, required this.onFieldSubmitted});

  final Function onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return InputText(
      hintText: 'Correo electrónico',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.mail_outline),
      onChanged: (email) {
        context.read<ForgotPasswordBloc>().add(ChangeEmailEvent(email));
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => onFieldSubmitted(),
      validator: (_) {
        final bloc = context.read<ForgotPasswordBloc>();
        final email = bloc.state.email;

        if (email.isValid) return null;

        switch (email.error!) {
          case EmailValidationError.invalid:
            return 'Email inválido';
        }
      },
    );
  }
}
