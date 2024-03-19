import 'package:flutter/material.dart';

class ForgotPasswordImage extends StatelessWidget {
  const ForgotPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/forgot-password.png',
      width: 155,
      height: 155,
    );
  }
}
