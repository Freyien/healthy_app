import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/reset_password/ui/bloc/reset_password_bloc.dart';
import 'package:healthy_app/features/common/reset_password/ui/widgets/counter.dart';
import 'package:healthy_app/features/common/reset_password/ui/widgets/resend_email_button.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ResetPasswordBloc>()..add(SetEmailEvent(email)),
      child: _Content(email),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content(this.email);

  final String email;

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width * .7;
    final appColors = context.appColors;

    return Scaffold(
      appBar: AppBar(
        actions: [
          CupertinoButton(
            child: Text('Iniciar sesión'),
            onPressed: () {
              context.goNamed('sign_in');
            },
          )
        ],
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<ResetPasswordBloc, ResetPasswordState>(
              listenWhen: (p, c) => p.savingStatus != c.savingStatus,
              listener: _resetPasswordListener,
            ),
          ],
          child: ScrollFillRemaining(
            child: Column(
              children: [
                // Animation
                FadeInDown(
                  from: 30,
                  child: Container(
                    width: size,
                    height: size,
                    child: FadeIn(
                      child: Lottie.asset(
                        'assets/animations/send_email.json',
                        width: size,
                        controller: controller,
                        onLoaded: (composition) async {
                          await Future.delayed(Duration(milliseconds: 450));
                          controller
                            ..duration = composition.duration
                            ..forward();
                        },
                        repeat: false,
                      ),
                    ),
                  ),
                ),
                VerticalSpace.large(),

                Expanded(
                  child: FadeInUp(
                    from: 10,
                    delay: Duration(milliseconds: 2000),
                    child: Column(
                      children: [
                        // Title
                        Text(
                          'Por favor, verifica tu email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: appColors.textContrast,
                            letterSpacing: -.5,
                          ),
                        ),
                        VerticalSpace.xlarge(),

                        // Subtitle
                        Text(
                          'Enviamos un correo a:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                context.appColors.textContrast!.withOpacity(.7),
                          ),
                        ),

                        Text(
                          widget.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: appColors.textContrast,
                          ),
                        ),

                        VerticalSpace.xxxlarge(),
                        Text(
                          'Haga clic en el enlace de ese correo electrónico para cambiar su contraseña. Si no lo ve, es posible que deba revisar su carpeta de spam.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                context.appColors.textContrast!.withOpacity(.7),
                          ),
                        ),

                        Spacer(),
                        VerticalSpace.xlarge(),
                        Text(
                          '¿Aún no encuentras el correo electrónico?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                context.appColors.textContrast!.withOpacity(.7),
                          ),
                        ),

                        VerticalSpace.medium(),

                        // Resend email button
                        ResendEmailButton(),
                        VerticalSpace.small(),

                        // Counter
                        Counter(),
                      ],
                    ),
                  ),
                ),

                VerticalSpace.medium(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetPasswordListener(BuildContext context, ResetPasswordState state) {
    switch (state.savingStatus) {
      case SavingStatus.initial:
        break;
      case SavingStatus.loading:
        return LoadingUtils.show(context);
      case SavingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SavingStatus.success:
        return LoadingUtils.hide(context);
    }
  }
}
