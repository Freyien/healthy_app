import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';

class SignUpAppleButton extends StatelessWidget {
  const SignUpAppleButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) return SizedBox.shrink();

    return CustomOutlineButton(
      onPressed: onPressed,
      text: 'Continuar con Apple',
      leading: Icon(
        Icons.apple,
        color: Colors.black,
        size: 35,
      ),
    );
  }
}
