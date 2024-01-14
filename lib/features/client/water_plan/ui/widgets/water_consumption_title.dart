import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class WaterConsumptionTitle extends StatelessWidget {
  const WaterConsumptionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Historial de consumo',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: context.appColors.textContrast,
      ),
    );
  }
}
