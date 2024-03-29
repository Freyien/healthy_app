import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class SignInAppleButton extends StatelessWidget {
  const SignInAppleButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) return SizedBox.shrink();

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(60, 65),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.zero,
        elevation: 0,
      ),
      child: Icon(
        Icons.apple,
        color: context.appColors.textContrast,
        size: 35,
      ),
    );
  }
}
