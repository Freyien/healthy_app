import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return RichText(
      text: TextSpan(
        text: '¿Ya tienes una cuenta? ',
        style: TextStyle(color: appColors.primaryText),
        children: [
          TextSpan(
            text: 'Inicial sesión',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: appColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed('sign_in');
              },
          ),
        ],
      ),
    );
  }
}
