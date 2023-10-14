import 'package:flutter/material.dart';

class SignInTitle extends StatelessWidget {
  const SignInTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Bienvenid@',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
      ),
    );
  }
}
