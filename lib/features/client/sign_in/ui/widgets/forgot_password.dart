import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => context.pushNamed('forgot_password'),
        child: Text(
          '¿Olvidaste tu contraseña?',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: context.appColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
