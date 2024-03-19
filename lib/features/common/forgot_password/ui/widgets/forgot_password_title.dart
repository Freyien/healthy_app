import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class ForgotPasswordTitle extends StatelessWidget {
  const ForgotPasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '¿Olvidaste tu contraseña?',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.appColors.textContrast,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}
