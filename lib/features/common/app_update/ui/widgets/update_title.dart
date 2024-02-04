import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class UpdateTitle extends StatelessWidget {
  const UpdateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Estamos mejorando',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: context.appColors.textContrast,
        letterSpacing: -.3,
      ),
    );
  }
}
