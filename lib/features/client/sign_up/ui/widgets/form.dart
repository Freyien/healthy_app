import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';
import 'package:healthy_app/core/ui/widgets/circle_icon_button.dart';
import 'package:healthy_app/core/ui/widgets/input_text.dart';
import 'package:healthy_app/core/ui/widgets/primary_button.dart';
import 'package:healthy_app/core/ui/widgets/vertical_space.dart';
import 'package:healthy_app/features/client/sign_up/domain/entities/entities.dart';
import 'package:healthy_app/features/client/sign_up/ui/bloc/sign_up_bloc.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final key = GlobalKey<FormState>();

    return Form(
      key: key,
      child: Column(
        children: [
          // Email input
          const _EmailInput(),

          // Password input
          const _PasswordInput(),
          VerticalSpace.small(),

          PrimaryButton(
            text: 'Crear cuenta',
            onPressed: () {
              Keyboard.close(context);
              if (!key.currentState!.validate()) {
                return;
              }

              context
                  .read<AnalyticsBloc>()
                  .add(LogEvent('SignUpButtonPressed'));

              context.read<SignUpBloc>().add(const SignUpwithEmailEvent());
            },
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return InputText(
      hintText: 'Correo electrónico',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.mail_outline),
      onChanged: (email) {
        context.read<SignUpBloc>().add(ChangeEmailEvent(email));
      },
      validator: (_) {
        final bloc = context.read<SignUpBloc>();
        final email = bloc.state.signUpForm.email;

        if (email.valid) return null;

        switch (email.error!) {
          case EmailValidationError.invalid:
            return 'Email inválido';
        }
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();

    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (p, c) =>
          c.signUpForm.showPassword != p.signUpForm.showPassword,
      builder: (context, state) {
        final showPassword = !state.signUpForm.showPassword;

        return InputText(
          hintText: 'Contraseña',
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: CircleIconButton(
            onPressed: () {
              bloc.add(const ChangeShowPasswordEvent());
            },
            icon: showPassword
                ? const Icon(CupertinoIcons.eye_slash)
                : const Icon(CupertinoIcons.eye),
          ),
          obscureText: showPassword,
          textInputAction: TextInputAction.done,
          onChanged: (password) {
            bloc.add(ChangePasswordEvent(password));
          },
          validator: (_) {
            final password = bloc.state.signUpForm.password;
            if (password.valid) return null;

            switch (password.error!) {
              case PasswordError.empty:
                return 'Campo obligatorio';
            }
          },
        );
      },
    );
  }
}
