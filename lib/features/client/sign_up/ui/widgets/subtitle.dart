import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class SignUpSubtitle extends StatelessWidget {
  const SignUpSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Estás a unos pasos de comenzar una nueva vida',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.appColors.textContrast,
      ),
    );
  }
}
