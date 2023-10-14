import 'package:flutter/material.dart';

class SignUpSubtitle extends StatelessWidget {
  const SignUpSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Estás a unos pasos de comenzar una nueva vida',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
