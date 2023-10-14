import 'package:flutter/material.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Crea una cuenta',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
      ),
    );
  }
}
