import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class NotificationTitle extends StatelessWidget {
  const NotificationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Text(
      'No te pierdas nuestras promociones',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: appColors.textContrast,
        letterSpacing: -.5,
      ),
    );
  }
}
