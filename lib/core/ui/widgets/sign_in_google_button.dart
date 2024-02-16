import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInGoogleButton extends StatelessWidget {
  const SignInGoogleButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
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
      child: SvgPicture.asset(
        'assets/svg/google.svg',
        width: 25,
      ),
    );
  }
}
