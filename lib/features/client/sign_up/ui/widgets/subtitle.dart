import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class SignUpSubtitle extends StatelessWidget {
  const SignUpSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienestar, buena alimentación y amor propio',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.appColors.textContrast,
      ),
    );
  }
}
