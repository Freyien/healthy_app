import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/forgot_password/ui/bloc/forgot_password_bloc.dart';
import 'package:healthy_app/features/common/forgot_password/ui/widgets/forgot_password_email_input.dart';
import 'package:healthy_app/features/common/forgot_password/ui/widgets/forgot_password_image.dart';
import 'package:healthy_app/features/common/forgot_password/ui/widgets/forgot_password_subtitle.dart';
import 'package:healthy_app/features/common/forgot_password/ui/widgets/forgot_password_title.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => sl<ForgotPasswordBloc>(),
      child: Scaffold(
        appBar: AppBar(),
        body: Builder(builder: (context) {
          return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
            listenWhen: (p, c) => p.resetStatus != c.resetStatus,
            listener: _resetPasswordListener,
            child: ScrollFillRemaining(
              child: PaddingFormColumn(
                padding: EdgeInsets.zero,
                formKey: formKey,
                children: [
                  Spacer(),

                  // Image
                  ForgotPasswordImage(),
                  VerticalSpace.xxxlarge(),

                  // Title
                  ForgotPasswordTitle(),
                  VerticalSpace.medium(),

                  // Subtitle
                  ForgotPasswordSubtitle(),
                  VerticalSpace.xxxlarge(),

                  // Email input
                  ForgotPasswordEmailInput(
                    onFieldSubmitted: () =>
                        _sendPasswordResetEmail(context, formKey),
                  ),
                  VerticalSpace.medium(),

                  // Send email button
                  Spacer(),
                  PrimaryButton(
                    text: 'Enviar correo',
                    onPressed: () => _sendPasswordResetEmail(context, formKey),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _sendPasswordResetEmail(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) {
    if (!formKey.currentState!.validate()) return;

    context.read<ForgotPasswordBloc>().add(SendPasswordResetEmailEvent());
  }

  void _resetPasswordListener(BuildContext context, ForgotPasswordState state) {
    switch (state.resetStatus) {
      case SavingStatus.initial:
        break;
      case SavingStatus.loading:
        LoadingUtils.show(context);
        break;
      case SavingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SavingStatus.success:
        LoadingUtils.hide(context);

        final email = context.read<ForgotPasswordBloc>().state.email.value;
        context.pushReplacementNamed('reset_password', extra: {
          'email': email,
        });
        break;
    }
  }
}
