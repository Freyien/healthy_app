import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class SignInSubtitle extends StatelessWidget {
  const SignInSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Iniciemos sesión para comenzar a mejorar vidas',
      style: TextStyle(
        color: context.appColors.textContrast,
      ),
    );
  }
}
