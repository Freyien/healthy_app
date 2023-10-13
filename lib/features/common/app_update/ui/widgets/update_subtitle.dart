import 'package:flutter/material.dart';

class UpdateSubtitle extends StatelessWidget {
  const UpdateSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Actualiza la app para que no te pierdas de las promociones y descuentos que tenemos para ti',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey,
      ),
    );
  }
}
