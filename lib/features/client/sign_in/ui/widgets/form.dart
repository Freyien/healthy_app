import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';
import 'package:healthy_app/core/ui/widgets/circle_icon_button.dart';
import 'package:healthy_app/core/ui/widgets/input_text.dart';
import 'package:healthy_app/core/ui/widgets/primary_button.dart';
import 'package:healthy_app/core/ui/widgets/vertical_space.dart';
import 'package:healthy_app/features/client/sign_in/domain/entities/entities.dart';
import 'package:healthy_app/features/client/sign_in/ui/bloc/sign_in_bloc.dart';
import 'package:healthy_app/features/client/sign_in/ui/widgets/forgot_password.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    return Form(
      key: key,
      child: Column(
        children: [
          // Email input
          const _EmailInput(),

          // Password input
          const _PasswordInput(),

          // Forgot password
          ForgotPassword(),
          VerticalSpace.large(),

          PrimaryButton(
            text: 'Iniciar sesión',
            onPressed: () {
              Keyboard.close(context);
              if (!key.currentState!.validate()) {
                return;
              }

              context
                  .read<AnalyticsBloc>()
                  .add(LogEvent('signInButtonPressed'));

              context.read<SignInBloc>().add(const SignInwithEmailEvent());
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
        context.read<SignInBloc>().add(ChangeEmailEvent(email));
      },
      validator: (_) {
        final bloc = context.read<SignInBloc>();
        final email = bloc.state.signInForm.email;

        if (email.isValid) return null;

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
    final bloc = context.read<SignInBloc>();

    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (p, c) =>
          c.signInForm.showPassword != p.signInForm.showPassword,
      builder: (context, state) {
        final showPassword = !state.signInForm.showPassword;

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
            final password = bloc.state.signInForm.password;
            if (password.isValid) return null;

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
