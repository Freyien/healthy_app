import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class ForgotPasswordSubtitle extends StatelessWidget {
  const ForgotPasswordSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Ingresa tu correo electrónico para recibir un link y restablecer tu contraseña',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.appColors.textContrast!.withOpacity(.7),
        fontSize: 16,
      ),
    );
  }
}
